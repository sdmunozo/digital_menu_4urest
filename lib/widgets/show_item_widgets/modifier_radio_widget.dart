import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class ModifierRadioWidget extends StatefulWidget {
  final BaseModelModifier modifier;
  final String? groupValue;
  final Function(String?) onChanged;

  const ModifierRadioWidget({
    super.key,
    required this.modifier,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ModifierRadioWidgetState createState() => _ModifierRadioWidgetState();
}

class _ModifierRadioWidgetState extends State<ModifierRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.modifier.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Row(
            children: [
              SizedBox(
                width: widget.modifier.image.isEmpty ? 0 : 40,
                height: 40,
                child: widget.modifier.image.isEmpty
                    ? Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                      )
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          width: GlobalConfigProvider.maxWidth *
                                              0.9,
                                          height:
                                              GlobalConfigProvider.maxHeight *
                                                  0.7,
                                          color: Colors.white,
                                          child: Center(
                                            child: Image.network(
                                              widget.modifier.image,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 16,
                                        right: 16,
                                        child: IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Image.network(widget.modifier.image),
                      ),
              ),
              const SizedBox(width: 5),
              Text(
                widget.modifier.alias,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              if (widget.modifier.price > 0) ...[
                Text("+\$${widget.modifier.price.toStringAsFixed(2)}"),
                const SizedBox(width: 5),
              ],
              const SizedBox(width: 5),
              Radio<String>(
                value: widget.modifier.id,
                groupValue: widget.groupValue,
                onChanged: widget.onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/* Respaldo con contraccion y expansion de los grupos de mod

class ModifierRadioWidget extends StatefulWidget {
  final ModifierModel modifier;
  final String? groupValue;
  final Function(String?) onChanged;

  const ModifierRadioWidget({
    super.key,
    required this.modifier,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ModifierRadioWidgetState createState() => _ModifierRadioWidgetState();
}

class _ModifierRadioWidgetState extends State<ModifierRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.modifier.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image(
                  image: CustomImageProvider.getNetworkImageIP(
                      widget.modifier.image),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                widget.modifier.alias,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                (widget.modifier.price.isNotEmpty &&
                        widget.modifier.price != '0')
                    ? "\$${double.parse(widget.modifier.price).toStringAsFixed(2)}"
                    : '',
              ),
              const SizedBox(width: 5),
              Radio<String>(
                value: widget.modifier.id,
                groupValue: widget.groupValue,
                onChanged: widget.onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */