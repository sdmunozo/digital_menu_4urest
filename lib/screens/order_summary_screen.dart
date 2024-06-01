//https://wa.me/+8131081423?text=Resumen%20de%20la%20orden%3A%0AProducto%3A%20Big%20Mac%0ACantidad%3A%202%0APresentaci%C3%B3n%3A%20Sencilla%0APapas%3A%20Papas%20Chicas%0ABebidas%3A%20Bebida%20Chica%0AExtras%3A%20Extra%20Queso%2C%20Extra%20Bacon%0ATotal%3A%20%24310.00%0AProducto%3A%20Cuarto%20de%20libra%20con%20queso%0ACantidad%3A%202%0ANotas%3A%20TEST%0APresentaci%C3%B3n%3A%20Sencilla%0APapas%3A%20Papas%20Chicas%0ABebidas%3A%20Bebida%20Grande%0AExtras%3A%20Extra%20Queso%2C%20Extra%20Bacon%2C%20Extra%20Cebolla%0ATotal%3A%20%24360.00%0AMonto%20Total%3A%20%24670.00

import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/orders/order_summary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryScreen extends StatelessWidget {
  final OrderSummaryController orderSummaryController = Get.find();

  OrderSummaryScreen({super.key});

  BaseModelProduct? _getProductById(String productId) {
    var catalog =
        GlobalConfigProvider.branchCatalog?.brand.branches[0].catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        if (product.id == productId) {
          return product;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resumen de la Orden'),
        ),
        body: Obx(() {
          if (orderSummaryController.orderSummary.value.orderItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay productos en la orden.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Regresar al Menú',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              ...orderSummaryController.orderSummary.value.orderItems
                  .map((orderItem) {
                BaseModelProduct? product =
                    _getProductById(orderItem.product.id);
                if (product == null) {
                  return const SizedBox.shrink();
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Mostrar un contenedor rojo si la imagen es vacía
                            (product.image.isNotEmpty)
                                ? Image.network(
                                    product.image,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 75,
                                    height: 75,
                                    color: Colors.grey,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.white,
                                    ),
                                  ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.alias,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  ...orderItem.product.modifiersGroups
                                      .where(
                                          (group) => group.modifiers.isNotEmpty)
                                      .map((group) {
                                    List<String> modifierAliases =
                                        group.modifiers.map((modifier) {
                                      return modifier.alias;
                                    }).toList();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: '${group.alias}: ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: modifierAliases.join(', '),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  if (orderItem.notes.isNotEmpty)
                                    const SizedBox(height: 10),
                                  if (orderItem.notes.isNotEmpty)
                                    Text('Notas: ${orderItem.notes}'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    orderSummaryController
                                        .updateProductQuantity(
                                            orderItem.orderItemId,
                                            orderItem.quantity + 1);
                                  },
                                ),
                                Text('${orderItem.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (orderItem.quantity > 1) {
                                      orderSummaryController
                                          .updateProductQuantity(
                                              orderItem.orderItemId,
                                              orderItem.quantity - 1);
                                    } else {
                                      orderSummaryController
                                          .removeProduct(orderItem.orderItemId);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //const Text('Total del producto:'),
                            Text(
                                '\$${(orderItem.totalAmount).toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    orderSummaryController.orderSummary.value.notes = value;
                    orderSummaryController.orderSummary.refresh();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nota del pedido',
                    hintText: 'Ingrese notas adicionales aquí',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Obx(() => Text(
                          '\$${orderSummaryController.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              if (orderSummaryController
                  .orderSummary.value.orderItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      orderSummaryController
                          .sendOrderSummaryToWhatsApp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enviar pedido',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}


/*
class OrderSummaryScreen extends StatelessWidget {
  final OrderSummaryController orderSummaryController = Get.find();

  OrderSummaryScreen({super.key});

  ProductModel? _getProductById(String productId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        if (product.id == productId) {
          return product;
        }
      }
    }
    return null;
  }

  ModifierModel? _getModifierById(String modifierId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        for (var modifierGroup in product.modifiersGroups) {
          for (var modifier in modifierGroup.modifiers) {
            if (modifier.id == modifierId) {
              return modifier;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resumen de la Orden'),
        ),
        body: Obx(() {
          if (orderSummaryController.orderSummary.value.orderItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay productos en la orden.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Regresar al Menú',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              ...orderSummaryController.orderSummary.value.orderItems
                  .map((orderItem) {
                ProductModel? product = _getProductById(orderItem.product.id);
                if (product == null) {
                  return const SizedBox.shrink();
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // ignore: unnecessary_null_comparison
                            product.image != null
                                ? Image.network(
                                    product.image,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.alias,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  ...orderItem.product.modifiersGroups
                                      .where(
                                          (group) => group.modifiers.isNotEmpty)
                                      .map((group) {
                                    List<String> modifierAliases =
                                        group.modifiers.map((modifier) {
                                      return modifier.alias;
                                    }).toList();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: '${group.alias}: ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: modifierAliases.join(', '),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  if (orderItem.notes.isNotEmpty)
                                    const SizedBox(height: 10),
                                  if (orderItem.notes.isNotEmpty)
                                    Text('Notas: ${orderItem.notes}'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    orderSummaryController
                                        .updateProductQuantity(
                                            orderItem.orderItemId,
                                            orderItem.quantity + 1);
                                  },
                                ),
                                Text('${orderItem.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (orderItem.quantity > 1) {
                                      orderSummaryController
                                          .updateProductQuantity(
                                              orderItem.orderItemId,
                                              orderItem.quantity - 1);
                                    } else {
                                      orderSummaryController
                                          .removeProduct(orderItem.orderItemId);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //const Text('Total del producto:'),
                            Text(
                                '\$${(orderItem.totalAmount).toStringAsFixed(2)}'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              orderSummaryController.orderSummary.value.notes =
                                  value;
                              orderSummaryController.orderSummary.refresh();
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Notas generales',
                              hintText: 'Ingrese notas adicionales aquí',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Obx(() => Text(
                          '\$${orderSummaryController.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              if (orderSummaryController
                  .orderSummary.value.orderItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      orderSummaryController
                          .sendOrderSummaryToWhatsApp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enviar por WhatsApp',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

*/


/*

Respaldo hasta enviar whatsapp sin datos de cliente
class OrderSummaryScreen extends StatelessWidget {
  final OrderSummaryController orderSummaryController = Get.find();

  OrderSummaryScreen({super.key});

  ProductModel? _getProductById(String productId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        if (product.id == productId) {
          return product;
        }
      }
    }
    return null;
  }

  ModifierModel? _getModifierById(String modifierId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        for (var modifierGroup in product.modifiersGroups) {
          for (var modifier in modifierGroup.modifiers) {
            if (modifier.id == modifierId) {
              return modifier;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resumen de la Orden'),
        ),
        body: Obx(() {
          if (orderSummaryController.orderSummary.value.orderItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay productos en la orden.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Regresar al Menú',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              ...orderSummaryController.orderSummary.value.orderItems
                  .map((orderItem) {
                ProductModel? product = _getProductById(orderItem.product.id);
                if (product == null) {
                  return const SizedBox.shrink();
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // ignore: unnecessary_null_comparison
                            product.image != null
                                ? Image.network(
                                    product.image,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.alias,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  ...orderItem.product.modifiersGroups
                                      .where(
                                          (group) => group.modifiers.isNotEmpty)
                                      .map((group) {
                                    List<String> modifierAliases =
                                        group.modifiers.map((modifier) {
                                      return modifier.alias;
                                    }).toList();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: '${group.alias}: ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: modifierAliases.join(', '),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  if (orderItem.notes.isNotEmpty)
                                    const SizedBox(height: 10),
                                  if (orderItem.notes.isNotEmpty)
                                    Text('Notas: ${orderItem.notes}'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    orderSummaryController
                                        .updateProductQuantity(
                                            orderItem.orderItemId,
                                            orderItem.quantity + 1);
                                  },
                                ),
                                Text('${orderItem.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (orderItem.quantity > 1) {
                                      orderSummaryController
                                          .updateProductQuantity(
                                              orderItem.orderItemId,
                                              orderItem.quantity - 1);
                                    } else {
                                      orderSummaryController
                                          .removeProduct(orderItem.orderItemId);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total del producto:'),
                            Text(
                                '\$${(orderItem.totalAmount).toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Obx(() => Text(
                          '\$${orderSummaryController.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              if (orderSummaryController
                  .orderSummary.value.orderItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      orderSummaryController.sendOrderSummaryToWhatsApp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enviar por WhatsApp',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

*/

/* RESPALDO HASTA ANTES DE WHATSAPP

class OrderSummaryScreen extends StatelessWidget {
  final OrderSummaryController orderSummaryController = Get.find();

  OrderSummaryScreen({super.key});

  ProductModel? _getProductById(String productId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        if (product.id == productId) {
          return product;
        }
      }
    }
    return null;
  }

  ModifierModel? _getModifierById(String modifierId) {
    var catalog = GlobalConfigProvider.branchCatalog?.catalogs;
    if (catalog == null || catalog.isEmpty) {
      return null;
    }

    for (var category in catalog[0].categories) {
      for (var product in category.products) {
        for (var modifierGroup in product.modifiersGroups) {
          for (var modifier in modifierGroup.modifiers) {
            if (modifier.id == modifierId) {
              return modifier;
            }
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resumen de la Orden'),
        ),
        body: Obx(() {
          if (orderSummaryController.orderSummary.value.orderItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay productos en la orden.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Regresar al Menú',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              ...orderSummaryController.orderSummary.value.orderItems
                  .map((orderItem) {
                ProductModel? product = _getProductById(orderItem.product.id);
                if (product == null) {
                  return const SizedBox.shrink();
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // ignore: unnecessary_null_comparison
                            product.image != null
                                ? Image.network(
                                    product.image,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.alias,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  ...orderItem.product.modifiersGroups
                                      .where(
                                          (group) => group.modifiers.isNotEmpty)
                                      .map((group) {
                                    List<String> modifierAliases =
                                        group.modifiers.map((modifier) {
                                      return modifier.alias;
                                    }).toList();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: '${group.alias}: ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: modifierAliases.join(', '),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  if (orderItem.notes.isNotEmpty)
                                    const SizedBox(height: 10),
                                  if (orderItem.notes.isNotEmpty)
                                    Text('Notas: ${orderItem.notes}'),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    orderSummaryController
                                        .updateProductQuantity(
                                            orderItem.orderItemId,
                                            orderItem.quantity + 1);
                                  },
                                ),
                                Text('${orderItem.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (orderItem.quantity > 1) {
                                      orderSummaryController
                                          .updateProductQuantity(
                                              orderItem.orderItemId,
                                              orderItem.quantity - 1);
                                    } else {
                                      orderSummaryController
                                          .removeProduct(orderItem.orderItemId);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total del producto:'),
                            Text(
                                '\$${(orderItem.totalAmount).toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Obx(() => Text(
                          '\$${orderSummaryController.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              if (orderSummaryController
                  .orderSummary.value.orderItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      orderSummaryController.printOrderSummary();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Imprimir en Consola',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

*/

