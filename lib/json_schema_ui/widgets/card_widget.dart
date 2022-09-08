import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';
import '../models/mapPath.dart';
import '../models/widget_data.dart';
import '../utils.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late final Map<String, dynamic> schema;
  late final Map<String, dynamic> uiSchema;
  late final MapPath path;
  late final Map schemaProperties;
  late final List sortedCardsByOrder;
  late int index;
  late bool hasCardFields;

  @override
  void initState() {
    schema = widget.widgetData.schema;
    uiSchema = widget.widgetData.uiSchema ?? {};
    path = widget.widgetData.path;
    schemaProperties = schema['properties'];
    sortedCardsByOrder = Utils()
        .retrieveSchemaFields(schema: schema, uiSchema: uiSchema, context: context, path: path);
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List cardFields = [];
    List cards = [];
    dynamic card = sortedCardsByOrder[index];

    Widget onNextCardButton = Row(children: [
      const SizedBox(width: 10.0),
      Container(
          padding: const EdgeInsets.all(4.0),
          color: Colors.blueGrey,
          child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                setState(() {
                  index++;
                  if (index == sortedCardsByOrder.length) index = 0;
                });
              })),
    ]);

    if (schemaProperties[card]['properties'] != null) {
      cardFields = Utils().retrieveSchemaFields(
          schema: schemaProperties[card], uiSchema: uiSchema[card], context: context, path: path);
      hasCardFields = true;
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Cards(
                schema: schema,
                uiSchema: uiSchema,
                path: path,
                schemaProperties: schemaProperties,
                card: card,
                cards: cards,
                cardFields: cardFields,
                hasCardFields: hasCardFields),
            onNextCardButton
          ],
        ),
      );
    } else {
      cards.add(card);
      hasCardFields = false;
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Cards(
                schema: schema,
                uiSchema: uiSchema,
                path: path,
                schemaProperties: schemaProperties,
                card: card,
                cards: cards,
                cardFields: cardFields,
                hasCardFields: hasCardFields),
            onNextCardButton
          ],
        ),
      );
    }
  }
}

class Cards extends StatelessWidget {
  const Cards(
      {Key? key,
      required this.schema,
      required this.uiSchema,
      required this.path,
      required this.schemaProperties,
      required this.card,
      required this.cards,
      required this.cardFields,
      required this.hasCardFields})
      : super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> uiSchema;
  final MapPath path;
  final Map schemaProperties;
  final String card;
  final List cards;
  final List cardFields;
  final bool hasCardFields;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      width: 300.0,
      color: Colors.blueGrey,
      child: hasCardFields
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: cardFields.length,
              itemBuilder: (BuildContext context, int i) {
                dynamic cardProperty = cardFields[i];
                MapPath cardPropertyPath = path.add(schemaProperties[card]['type'], card);
                return ObjectBody(
                    schema: schemaProperties[card],
                    uiSchema: uiSchema[card],
                    path: cardPropertyPath,
                    field: cardProperty,
                    disabled: false);
              })
          : ListView.builder(
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int i) {
                return ObjectBody(
                  schema: schema,
                  uiSchema: uiSchema,
                  path: path,
                  field: card,
                  disabled: false,
                );
              },
            ),
    );
  }
}