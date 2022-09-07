import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';

import '../models/mapPath.dart';
import '../utils.dart';

class CardWidget extends StatefulWidget {
  // const CardWidget({Key? key, required this.widgetData}) : super(key: key);
  //final WidgetData widgetData;

  const CardWidget({Key? key, required this.schema, required this.uiSchema, required this.path}) : super(key: key);
  final Map<String, dynamic> schema;
  final Map<String, dynamic> uiSchema;
  final MapPath path;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late final Map<String, dynamic> schemaProperties;
  late final Map<String, dynamic> uiSchema;
  late final MapPath path;
  late final List cards;
  late int index;

  @override
  void initState() {
    schemaProperties = widget.schema['properties'] ?? {};
    uiSchema = widget.uiSchema;
    path = widget.path;
    cards = Utils()
        .retrieveSchemaFields(schema: widget.schema, uiSchema: uiSchema, context: context, path: path);
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic card = cards[index];
    List cardQuestions = Utils()
        .retrieveSchemaFields(schema: schemaProperties[card], uiSchema: uiSchema[card], context: context, path: path);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            width: 300.0,
            color: const Color.fromRGBO(168, 210, 219, 1),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cardQuestions.length,
              itemBuilder: (BuildContext context, int i) {
                dynamic cardQuestion = cardQuestions[i];
                MapPath cardQuestionPath = path.add(schemaProperties[card]['type'], card);
                return ObjectBody(
                  schema: schemaProperties[card],
                  uiSchema: uiSchema[card],
                  path: cardQuestionPath,
                  field: cardQuestion,
                  disabled: false);
              }),
          ),
          Row(children: [
            const SizedBox(width: 10.0),
            Container(
                padding: const EdgeInsets.all(4.0),
                color: const Color.fromRGBO(69, 123, 157, 1),
                child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        index++;
                        if (index == cards.length) index = 0;
                      });
                    }),
            ),
          ]),
        ]),
    );
  }
}