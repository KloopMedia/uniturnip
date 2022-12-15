class Schemas {
  static const Map<String, dynamic> arrayTest = {
    "label": "Simple",
    "schema": {
      "type": "object",
      "title": "Онлайн жолугушууга жазылуу / Запись на онлайн прием",
      "properties": {
        "instruction_link": {
          "title": "Эгер сизге форманы толтурууда жардам керек болсо, анда бул шилтемени басыңыз: / Если вам нужна помощь с заполнением формы, то нажмите на эту ссылку:",
          "type": "string",
          "default": "https://taplink.cc/koldonmo"
        },
        "name": {
          "title": "Толук аты жөнүңүз / ФИО",
          "type": "string"
        },
        "actual_address": {
          "title": " Жашаган дарегиңиз / Адрес проживания",
          "type": "string"
        },
        "nationality": {
          "title": "Улутуңуз / Национальность",
          "type": "string"
        },
        "age": {
          "title": "Жашыңыз / Ваш возраст",
          "type": "integer"
        },
        "marital_status": {
          "enum": [
            "Женат_Замужем",
            "Разведен_а",
            "Не женат_Не замужем",
            "Вдовец_Вдова"
          ],
          "title": "Үй-бүлөлүк абалыңыз / Ваше семейное положение",
          "type": "string",
          "enumNames": [
            "Үй-бүлөлүү / Женат/Замужем",
            "Ажырашкан / Разведен(а)",
            "Бойдок / Не женат/Не замужем",
            "Жесир / Вдовец/Вдова"
          ]
        },
        "employed": {
          "enum": [
            "Постоянная работа",
            "Непостоянная работа",
            "Неполная занятость",
            "Безработный_ая"
          ],
          "title": "Сиздин иш абалыңыз (жумушуңуз) / Статус вашей занятости (работа)",
          "type": "string",
          "enumNames": [
            "Туруктуу жумуш / Постоянная работа",
            "Убактылуу жумуш / Непостоянная работа",
            "Жарым күндүк жумуш / Неполная занятость",
            " Жумушсуз / Безработный(ая)"
          ]
        },
        "salary": {
          "enum": [
            "0 - 5000 сомов в месяц",
            "5000 - 10 000 сомов в месяц",
            "10 000 - 20 000 сомов в месяц",
            "20 000 - 30 000 сомов в месяц",
            "больше сомов 30 000 в месяц"
          ],
          "title": "Кирешеңиз / Ваш заработок составляет",
          "type": "string",
          "enumNames": [
            "айына 0 - 5000 сом / 0 - 5000 сомов в месяц",
            "айына 5000 - 10 000 сом / 5000 - 10 000 сомов в месяц",
            "айына 10 000 - 20 000 сом / 10 000 - 20 000 сомов в месяц",
            "айына 20 000 - 30 000 сом / 20 000 - 30 000 сомов в месяц",
            "айына 30 000 сомдон жогору / больше сомов 30 000 в месяц"
          ]
        },
        "benefits_or_pension": {
          "enum": [
            "Да",
            "Нет"
          ],
          "title": "Сиз же сиздин үй-бүлөңүздүн мүчөсү мамлекеттен социалдык жөлөкпул/пенсия алабы? / Получаете ли вы или член вашей семьи соц пособия/пенсии от государства?",
          "type": "string",
          "enumNames": [
            "Ооба / Да",
            "Жок / Нет"
          ]
        },
        "phone_number": {
          "title": "Телефон номериңиз / Номер телефона",
          "type": "integer"
        },
        "whatsapp_number": {
          "title": "WhatsApp номериңиз / WhatsApp номер",
          "type": "integer"
        },
        "region": {
          "enum": [
            "chuy_region",
            "naryn_region",
            "osh_region",
            "talas_region",
            "issyk-kul_region",
            "jalal-abad_region",
            "batken_region",
            "bishkek_city",
            "osh_city"
          ],
          "title": "Облусуңузду тандаңыз / Выберите свою область",
          "type": "string",
          "enumNames": [
            "Чуй облусу / Чуйская область",
            "Нарын облусу / Нарынская область",
            "Ош облусу / Ошская область",
            "Талас облусу / Таласская область",
            "Ысык-Көл облусу / Иссык-Кульская область",
            "Жалал-Абад облусу / Джалал-Абадская область",
            "Баткен облусу / Баткенская область",
            "Бишкек шаары / город Бишкек",
            "Ош шаары / город Ош"
          ]
        },
        "description_of_problem": {
          "title": "Көйгөйүңүздү мүнөздөп бериңиз / Опишите свою проблему",
          "type": "string"
        },
        "file": {
          "title": "Тиешелүү файлдарды, сүрөттөрдү, видеолорду, эгер бар болсо, тиркеңиз / Прикрепите нужные файлы, фотографии, видео, если они есть",
          "type": "string"
        },
        "meeting_with_whom": {
          "enum": [
            "ombudsman",
            "deputy_of_ombudsman_2",
          ],
          "title": "Жолугушууга кимге жазылууну тандаңыз: / Выберите к кому вы хотите записаться на прием:",
          "type": "string",
          "enumNames": [
            "Абдрахматова Атыр Болотбековна (Акыйкатчы / Омбудсмен)",
            "Колопов Альберт Сексенбаевич (Акыйкатчынын орун басары / Заместитель Омбудсмена)",
            "Азарбеков Аскат Нарынбекович (Акыйкатчы аппаратынын жетекчиси / Руководитель аппарата Омбудсмена)"
          ],
          "description": "Кимге жазылууну тандаган соң, 10 секунд күтө туруңуз, алдыда даталар пайда болот. Жолугушуу күнүн сөзсүз тандооңуз кажет. / После того, как вы выбрали к кому записаться, подождите 10 секунд. Внизу появятся даты, вам нужно обязательно выбрать день приема"
        },
        "date": {
          "enum": [
            "2022-08-05",
            "2022-08-12",
            "2022-08-19",
            "2022-08-26",
            "2022-09-02"
          ],
          "title": "Онлайн жолугушуунун датасын тандаңыз. Онлайн жолугушуулар жума күндөрү гана өткөрүлөт. / Выберите дату. Онлайн приемы проходят только по пятницам",
          "type": "string",
          "enumNames": [
            "05.08.2022",
            "12.08.2022",
            "19.08.2022",
            "26.08.2022",
            "02.09.2022"
          ],
          "description": "Жолугушуунун күнүн тандаган соң 10 секунд күтө туруңуз. Алдыда сааттар пайда болгон соң жолугушуунун убактысын сөзсүз тандооңуз кажет. / После выборы даты приема, подождите 10 секунд. Внизу появятся часы, вам нужно обязательно выбрать время"
        },
        "time": {
          "enum": [
            "t_10_00",
            "t_10_30",
            "t_11_00",
            "t_11_30",
            "t_12_00",
            "t_12_30",
            "t_14_00",
            "t_14_30",
            "t_15_00",
            "t_15_30",
            "t_16_00",
            "t_16_30"
          ],
          "title": "Убакытты тандаңыз / Выберите время",
          "type": "string",
          "enumNames": [
            "10:00",
            "10:30",
            "11:00",
            "11:30",
            "12:00",
            "12:30",
            "14:00",
            "14:30",
            "15:00",
            "15:30",
            "16:00",
            "16:30"
          ]
        },
        "names_of_zoom_participants": {
          "items": {
            "type": "string"
          },
          "type": "array",
          "description": "Онлайн жолугушууга сизден башка да кишилердин катышуусун кааласаңыз, алардын аты-жөнүн жазууңуз зарыл. Ал үчүн алдыдагы көк түстүү «+» баскычын басыңыз. / Если вы хотите, чтобы на онлайн приеме вместе с вами участвовали другие люди, вам необходимо вписать их ФИО.  Для этого нажмите на синюю кнопку «+» ниже.",
          "title": "Жолугушуунун катышуучулары / Участники встречи"
        },
        "comments": {
          "title": "Кошумча комментарийлериңиз болсо бул жерге жазыңыз / Если у вас есть какие-либо комментарии, напишите их здесь",
          "type": "string"
        },
        "note": {
          "title": "Жолугушууга каттооңуздун ырасталуусун күтүп турууңуз кажет. Жооп невыполненные бөлүмүндө пайда болот. / Вам нужно подождать подтверждения записи на прием. Ответ появится в разделе невыполненные.",
          "type": "object"
        }
      },
      "dependencies": {},
      "required": [
        "name",
        "actual_address",
        "nationality",
        "age",
        "marital_status",
        "employed",
        "salary",
        "benefits_or_pension",
        "phone_number",
        "whatsapp_number",
        "region",
        "description_of_problem",
        "meeting_with_whom",
        "date",
        "time"
      ],
      "description": "Суроолор пайда болсо 0999700001 номерине кайрылыңыз / Если возникли вопросы, обращайтесь по номеру 0999700001"
    },
    "ui": {
      "instruction_link": {
        "ui:widget": "customlink"
      },
      "marital_status": {
        "ui:widget": "radio"
      },
      "employed": {
        "ui:widget": "radio"
      },
      "salary": {
        "ui:widget": "radio"
      },
      "benefits_or_pension": {
        "ui:widget": "radio"
      },
      "region": {
        "ui:widget": "radio"
      },
      "description_of_problem": {
        "ui:widget": "textarea"
      },
      "file": {
        "ui:widget": "customfile",
        "ui:options": {
          "private": false,
          "multiple": true
        }
      },
      "meeting_with_whom": {
        "ui:widget": "radio"
      },
      "date": {
        "ui:widget": "radio"
      },
      "time": {
        "ui:widget": "radio"
      },
      "ui:order": [
        "instruction_link",
        "name",
        "actual_address",
        "nationality",
        "age",
        "marital_status",
        "employed",
        "salary",
        "benefits_or_pension",
        "phone_number",
        "whatsapp_number",
        "region",
        "description_of_problem",
        "file",
        "meeting_with_whom",
        "date",
        "time",
        "names_of_zoom_participants",
        "comments",
        "note"
      ]
    },
    "formData": {
      "test": [1, 2]
    }
  };
  static const Map<String, dynamic> test = {
    "label": "Simple",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "properties": {
        "newInput7": {
          "enum": [
            "Winter",
            "Spring",
            "Summer",
            "Autumn"
          ],
          "title": "New Input 7",
          "type": "string"
        },
        "newInput5": {
          "enum": [
            "One",
            "Two",
            "Three"
          ],
          "title": "New Input 5",
          "type": "string"
        },
        "newInput6": {
          "title": "New Input 6",
          "type": "string"
        },
        "newInput8": {
          "title": "New Input 8",
          "type": "number"
        }
      },
      "dependencies": {
        "newInput7": {
          "oneOf": [
            {
              "properties": {
                "newInput7": {
                  "enum": [
                    "Winter"
                  ]
                },
                "newInput1": {
                  "title": "New Input 1",
                  "type": "string"
                }
              },
              "required": [
                "newInput1"
              ]
            },
            {
              "properties": {
                "newInput7": {
                  "enum": [
                    "Spring"
                  ]
                },
                "newInput2": {
                  "title": "New Input 2",
                  "type": "boolean"
                }
              },
              "required": [
                "newInput2"
              ]
            },
            {
              "properties": {
                "newInput7": {
                  "enum": [
                    "Summer"
                  ]
                },
                "newInput3": {
                  "format": "date",
                  "title": "New Input 3",
                  "type": "string"
                }
              },
              "required": [
                "newInput3"
              ]
            },
            {
              "properties": {
                "newInput7": {
                  "enum": [
                    "Autumn"
                  ]
                },
                "newInput4": {
                  "format": "date-time",
                  "title": "New Input 4",
                  "type": "string"
                }
              },
              "required": [
                "newInput4"
              ]
            }
          ]
        }
      },
      "required": [
        "newInput7",
        "newInput5",
        "newInput6",
        "newInput8"
      ]
    },

    "ui": {
      "newInput7": {
        "ui:widget": "radio",
        "ui:column": ""
      },
      "newInput6": {
        "ui:widget": "textarea"
      },
      "ui:order": [
        "newInput7",
        "newInput1",
        "newInput2",
        "newInput3",
        "newInput4",
        "newInput5",
        "newInput6",
        "newInput8"
      ]
    },

    "formData": {
      "1": "test"
    }
  };

  static const Map<String, dynamic> test1 = {
    "label": "Simple",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "properties": {
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": {
            "type": "object",
            "properties": {
              "word": {"default": "Some word", "type": "string", "readOnly": true},
              "translation": {"default": "Какое-то слово", "type": "string", "readOnly": true},
              "count": {
                "title": "Кол-во нажатий",
                "default": 0,
                "type": "integer",
                "readOnly": true
              },
              "active": {"title": "Активен", "type": "boolean"}
            }
          }
        },
        "card": {
          "subtype": "card",
          "type": "object",
          "description": "Playground",
          "properties": {
            "q_1": {
              "title": "Pancakes",
              "type": "object",
              "properties": {
                "1_1": {
                  "enum": [
                    "a",
                    "b",
                    "c"
                  ],
                  "title": "Pancakes are:",
                  "type": "string",
                  "enumNames": [
                    "good ",
                    "bad",
                    "tasty"
                  ]
                },
                "1_2": {
                  "enum": [
                    "a",
                    "b",
                    "c"
                  ],
                  "title": "French toasts are:",
                  "type": "string",
                  "enumNames": [
                    "good ",
                    "bad",
                    "tasty"
                  ]
                }
              },
              "dependencies": {},
              "required": []
            },
            "q_2": {
              "title": "Waffles",
              "type": "object",
              "properties": {
                "2_1": {
                  "enum": [
                    "a",
                    "b",
                    "c"
                  ],
                  "title": "waffles are",
                  "type": "string",
                  "enumNames": [
                    "good",
                    "bad",
                    "tasty"
                  ]
                }
              },
              "dependencies": {},
              "required": []
            },
            "q_3": {
              "title": "Waffles",
              "type": "object",
              "properties": {
                "3_1": {
                  "title": "String field",
                  "type": "string"
                },
                "3_2": {
                  "type": "boolean",
                  "title": "checkbox (default)",
                  "description": "This is the checkbox-description"
                },
                "3_3": {
                  "type": "boolean",
                  "title": "select box",
                  "description": "This is the select-description"
                }
              },
              "dependencies": {},
              "required": []
            }
          },
          "dependencies": {},
          "required": []
        }
      }
    },
    "ui": {
      "fixedItemsList": {"ui:widget": "reader"},
      "card": {
        "q_1": {
          "1_1": {
            "ui:widget": "radio"
          },
          "1_2": {
            "ui:widget": "radio"
          },
          "ui:order": [
            "1_1",
            "1_2"
          ]
        },
        "q_2": {
          "2_1": {
            "ui:widget": "radio"
          },
          "ui:order": [
            "2_1"
          ]
        },
        "q_3": {
          "3_3": {
            "ui:widget": "select"
          },
          "ui:order": [
            "3_1",
            "3_2",
            "3_3"
          ]
        },
        "ui:order": [
          "q_1",
          "q_2",
          "q_3"
        ]
      }
    },
    "formData": {
      "fixedItemsList": [
        {"word": "The", "translation": "артикль", "count": 0, "active": true},
        {"word": "first", "translation": "первый", "count": 0, "active": true},
        {"word": "simple", "translation": "простой", "count": 0, "active": true},
        {"word": "text", "translation": "текст", "count": 0, "active": true}
      ]
    }
  };

  static Map<String, dynamic> simple = {
    "label": "Simple",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {"type": "string", "title": "First name"},
        "lastName": {"type": "string", "title": "Last name"},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {
        "ui:widget": "customfile",
      },
      "lastName": {"ui:emptyValue": "", "ui:autocomplete": "given-name"},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)"
      },
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "https://flutter-sound.canardoux.xyz/web_example/assets/extract/05.mp3",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static Map<String, dynamic> nested = {
    "label": "Nested",
    "schema": {
      "title": "A list of tasks",
      "type": "object",
      "required": ["title"],
      "properties": {
        "title": {"type": "string", "title": "Task list title"},
        "tasks": {
          "type": "array",
          "title": "Tasks",
          "items": {
            "type": "object",
            "required": ["title"],
            "properties": {
              "title": {"type": "string", "title": "Title", "description": "A sample title"},
              "details": {
                "type": "string",
                "title": "Task details",
                "description": "Enter the task details"
              },
              "done": {"type": "boolean", "title": "Done?", "default": false}
            }
          }
        }
      }
    },
    "ui": {
      "tasks": {
        "items": {
          "details": {"ui:widget": "textarea"}
        }
      }
    },
    "formData": {
      "title": "My current tasks",
      "tasks": [
        {
          "title": "My first task",
          "details":
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          "done": true
        },
        {
          "title": "My second task",
          "details":
              "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
          "done": false
        }
      ]
    }
  };

  static Map<String, dynamic> arrays = {
    "label": "Arrays",
    "schema": {
      "definitions": {
        "Thing": {
          "type": "object",
          "properties": {
            "name": {"type": "string", "default": "Default name"}
          }
        }
      },
      "type": "object",
      "properties": {
        "listOfStrings": {
          "type": "array",
          "title": "A list of strings",
          "items": {"type": "string", "default": "bazinga"}
        },
        "multipleChoicesList": {
          "type": "array",
          "title": "A multiple choices list",
          "items": {
            "type": "string",
            "enum": ["foo", "bar", "fuzz", "qux"]
          },
          "uniqueItems": true
        },
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": [
            {"title": "A string value", "type": "string", "default": "lorem ipsum"},
            {"title": "a boolean value", "type": "boolean"}
          ],
          "additionalItems": {"title": "Additional item", "type": "number"}
        },
        "minItemsList": {
          "type": "array",
          "title": "A list with a minimal number of items",
          "minItems": 3,
          "items": {"\$ref": "#/definitions/Thing"}
        },
        "defaultsAndMinItems": {
          "type": "array",
          "title": "List and item level defaults",
          "minItems": 5,
          "default": ["carp", "trout", "bream"],
          "items": {"type": "string", "default": "unidentified"}
        },
        "nestedList": {
          "type": "array",
          "title": "Nested list",
          "items": {
            "type": "array",
            "title": "Inner list",
            "items": {"type": "string", "default": "lorem ipsum"}
          }
        },
        "unorderable": {
          "title": "Unorderable items",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "unremovable": {
          "title": "Unremovable items",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "noToolbar": {
          "title": "No add, remove and order buttons",
          "type": "array",
          "items": {"type": "string", "default": "lorem ipsum"}
        },
        "fixedNoToolbar": {
          "title": "Fixed array without buttons",
          "type": "array",
          "items": [
            {"title": "A number", "type": "number", "default": 42},
            {"title": "A boolean", "type": "boolean", "default": false}
          ],
          "additionalItems": {"title": "A string", "type": "string", "default": "lorem ipsum"}
        }
      }
    },
    "ui": {
      "listOfStrings": {
        "items": {"ui:emptyValue": ""}
      },
      "multipleChoicesList": {"ui:widget": "checkboxes"},
      "fixedItemsList": {
        "items": [
          {"ui:widget": "textarea"},
          {"ui:widget": "select"}
        ],
        "additionalItems": {"ui:widget": "updown"}
      },
      "unorderable": {
        "ui:options": {"orderable": false}
      },
      "unremovable": {
        "ui:options": {"removable": false}
      },
      "noToolbar": {
        "ui:options": {"addable": false, "orderable": false, "removable": false}
      },
      "fixedNoToolbar": {
        "ui:options": {"addable": false, "orderable": false, "removable": false}
      }
    },
    "formData": {
      "listOfStrings": ["foo", "bar"],
      "multipleChoicesList": ["foo", "bar"],
      "fixedItemsList": ["Some text", true, 123],
      "minItemsList": [
        {"name": "Default name"},
        {"name": "Default name"},
        {"name": "Default name"}
      ],
      "defaultsAndMinItems": ["carp", "trout", "bream", "unidentified", "unidentified"],
      "nestedList": [
        ["lorem", "ipsum"],
        ["dolor"]
      ],
      "unorderable": ["one", "two"],
      "unremovable": ["one", "two"],
      "noToolbar": ["one", "two"],
      "fixedNoToolbar": [42, true, "additional item one", "additional item two"]
    }
  };
  static Map<String, dynamic> numbers = {
    "label": "Numbers",
    "schema": {
      "type": "object",
      "title": "Number fields & widgets",
      "properties": {
        "number": {"title": "Number", "type": "number"},
        "integer": {"title": "Integer", "type": "integer"},
        "numberEnum": {
          "type": "number",
          "title": "Number enum",
          "enum": [1, 2, 3]
        },
        "numberEnumRadio": {
          "type": "number",
          "title": "Number enum",
          "enum": [1, 2, 3]
        },
        "integerRange": {
          "title": "Integer range",
          "type": "integer",
          "minimum": 42,
          "maximum": 100
        },
        "integerRangeSteps": {
          "title": "Integer range (by 10)",
          "type": "integer",
          "minimum": 50,
          "maximum": 100,
          "multipleOf": 10
        }
      }
    },
    "ui": {
      "integer": {"ui:widget": "updown"},
      "numberEnumRadio": {
        "ui:widget": "radio",
        "ui:options": {"inline": true}
      },
      "integerRange": {"ui:widget": "range"},
      "integerRangeSteps": {"ui:widget": "range"}
    },
    "formData": {
      "number": 3.14,
      "integer": 42,
      "numberEnum": 2,
      "integerRange": 42,
      "integerRangeSteps": 80
    }
  };
  static Map<String, dynamic> widgets = {
    "label": "Widgets",
    "schema": {
      "title": "Widgets",
      "type": "object",
      "properties": {
        "stringFormats": {
          "type": "object",
          "title": "String formats",
          "properties": {
            "email": {"type": "string", "title": "email", "format": "email"},
            "uri": {"type": "string", "title": "uri", "format": "uri"}
          }
        },
        "boolean": {
          "type": "object",
          "title": "Boolean field",
          "properties": {
            "default": {
              "type": "boolean",
              "title": "checkbox (default)",
              "description": "This is the checkbox-description"
            },
            "radio": {
              "type": "boolean",
              "title": "radio buttons",
              "description": "This is the radio-description"
            },
            "select": {
              "type": "boolean",
              "title": "select box",
              "description": "This is the select-description"
            }
          }
        },
        "string": {
          "type": "object",
          "title": "String field",
          "properties": {
            "default": {"type": "string", "title": "text input (default)"},
            "textarea": {"type": "string", "title": "textarea"},
            "placeholder": {"type": "string"},
            "color": {"type": "string", "title": "color picker", "default": "#151ce6"}
          }
        },
        "secret": {"type": "string", "default": "I'm a hidden string."},
        "disabled": {"type": "string", "title": "A disabled field", "default": "I am disabled."},
        "readonly": {"type": "string", "title": "A readonly field", "default": "I am read-only."},
        "readonly2": {
          "type": "string",
          "title": "Another readonly field",
          "default": "I am also read-only.",
          "readOnly": true
        },
        "widgetOptions": {
          "title": "Custom widget with options",
          "type": "string",
          "default": "I am yellow"
        },
        "selectWidgetOptions": {
          "title": "Custom select widget with options",
          "type": "string",
          "enum": ["foo", "bar"],
          "enumNames": ["Foo", "Bar"]
        }
      }
    },
    "ui": {
      "boolean": {
        "radio": {"ui:widget": "radio"},
        "select": {"ui:widget": "select"}
      },
      "string": {
        "textarea": {
          "ui:widget": "textarea",
          "ui:options": {"rows": 5}
        },
        "placeholder": {"ui:placeholder": "This is a placeholder"},
        "color": {"ui:widget": "color"}
      },
      "secret": {"ui:widget": "hidden"},
      "disabled": {"ui:disabled": true},
      "readonly": {"ui:readonly": true},
      "widgetOptions": {
        "ui:options": {"backgroundColor": "yellow"}
      },
      "selectWidgetOptions": {
        "ui:options": {"backgroundColor": "pink"}
      }
    },
    "formData": {
      "stringFormats": {"email": "chuck@norris.net", "uri": "http://chucknorris.com/"},
      "boolean": {"default": true, "radio": true, "select": true},
      "string": {"color": "#151ce6", "default": "Hello...", "textarea": "... World"},
      "secret": "I'm a hidden string.",
      "disabled": "I am disabled.",
      "readonly": "I am read-only.",
      "readonly2": "I am also read-only.",
      "widgetOptions": "I am yellow"
    }
  };
  static Map<String, dynamic> ordering = {
    "label": "Ordering",
    "schema": {
      "title": "A registration form",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "password": {"type": "string", "title": "Password"},
        "lastName": {"type": "string", "title": "Last name"},
        "bio": {"type": "string", "title": "Bio"},
        "firstName": {"type": "string", "title": "First name"},
        "age": {"type": "integer", "title": "Age"}
      }
    },
    "ui": {
      "ui:order": ["firstName", "lastName", "*", "password"],
      "age": {"ui:widget": "updown"},
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password"}
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static Map<String, dynamic> references = {
    "label": "References",
    "schema": {
      "definitions": {
        "address": {
          "type": "object",
          "properties": {
            "street_address": {"type": "string"},
            "city": {"type": "string"},
            "state": {"type": "string"}
          },
          "required": ["street_address", "city", "state"]
        },
        "node": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "children": {
              "type": "array",
              "items": {"\$ref": "#/definitions/node"}
            }
          }
        }
      },
      "type": "object",
      "properties": {
        "billing_address": {"title": "Billing address", "\$ref": "#/definitions/address"},
        "shipping_address": {"title": "Shipping address", "\$ref": "#/definitions/address"},
        "tree": {"title": "Recursive references", "\$ref": "#/definitions/node"}
      }
    },
    "ui": {
      "ui:order": ["shipping_address", "billing_address", "tree"]
    },
    "formData": {
      "billing_address": {
        "street_address": "21, Jump Street",
        "city": "Babel",
        "state": "Neverland"
      },
      "shipping_address": {
        "street_address": "221B, Baker Street",
        "city": "London",
        "state": "N/A"
      },
      "tree": {
        "name": "root",
        "children": [
          {"name": "leaf"}
        ]
      }
    }
  };

  static Map<String, dynamic> custom = {
    "label": "Custom",
    "schema": {
      "title": "A localisation form",
      "type": "object",
      "required": ["lat", "lon"],
      "properties": {
        "lat": {"type": "number"},
        "lon": {"type": "number"}
      }
    },
    "ui": {"ui:field": "geo"},
    "formData": {"lat": 0, "lon": 0}
  };
  static Map<String, dynamic> errors = {
    "label": "Errors",
    "schema": {
      "title": "Contextualized errors",
      "type": "object",
      "properties": {
        "firstName": {"type": "string", "title": "First name", "minLength": 8, "pattern": "\\d+"},
        "active": {"type": "boolean", "title": "Active"},
        "skills": {
          "type": "array",
          "items": {"type": "string", "minLength": 5}
        },
        "multipleChoicesList": {
          "type": "array",
          "title": "Pick max two items",
          "uniqueItems": true,
          "maxItems": 2,
          "items": {
            "type": "string",
            "enum": ["foo", "bar", "fuzz"]
          }
        }
      }
    },
    "ui": {"": ""},
    "formData": {
      "firstName": "Chuck",
      "active": "wrong",
      "skills": ["karate", "budo", "aikido"],
      "multipleChoicesList": ["foo", "bar", "fuzz"]
    }
  };
  static Map<String, dynamic> examples = {
    "label": "Examples",
    "schema": {
      "title": "Examples",
      "description": "A text field with example values.",
      "type": "object",
      "properties": {
        "browser": {
          "type": "string",
          "title": "Browser",
          "examples": ["Firefox", "Chrome", "Opera", "Vivaldi", "Safari"]
        }
      }
    },
    "ui": {"": ""},
    "formData": {
      "firstName": "Chuck",
      "active": "wrong",
      "skills": ["karate", "budo", "aikido"],
      "multipleChoicesList": ["foo", "bar", "fuzz"]
    }
  };
  static Map<String, dynamic> large = {
    "label": "Large",
    "schema": {
      "definitions": {
        "largeEnum": {
          "type": "string",
          "enum": [
            "option #0",
            "option #1",
            "option #2",
            "option #3",
            "option #4",
            "option #5",
            "option #6",
            "option #7",
            "option #8",
            "option #9",
            "option #10",
            "option #11",
            "option #12",
            "option #13",
            "option #14",
            "option #15",
            "option #16",
            "option #17",
            "option #18",
            "option #19",
            "option #20",
            "option #21",
            "option #22",
            "option #23",
            "option #24",
            "option #25",
            "option #26",
            "option #27",
            "option #28",
            "option #29",
            "option #30",
            "option #31",
            "option #32",
            "option #33",
            "option #34",
            "option #35",
            "option #36",
            "option #37",
            "option #38",
            "option #39",
            "option #40",
            "option #41",
            "option #42",
            "option #43",
            "option #44",
            "option #45",
            "option #46",
            "option #47",
            "option #48",
            "option #49",
            "option #50",
            "option #51",
            "option #52",
            "option #53",
            "option #54",
            "option #55",
            "option #56",
            "option #57",
            "option #58",
            "option #59",
            "option #60",
            "option #61",
            "option #62",
            "option #63",
            "option #64",
            "option #65",
            "option #66",
            "option #67",
            "option #68",
            "option #69",
            "option #70",
            "option #71",
            "option #72",
            "option #73",
            "option #74",
            "option #75",
            "option #76",
            "option #77",
            "option #78",
            "option #79",
            "option #80",
            "option #81",
            "option #82",
            "option #83",
            "option #84",
            "option #85",
            "option #86",
            "option #87",
            "option #88",
            "option #89",
            "option #90",
            "option #91",
            "option #92",
            "option #93",
            "option #94",
            "option #95",
            "option #96",
            "option #97",
            "option #98",
            "option #99"
          ]
        }
      },
      "title": "A rather large form",
      "type": "object",
      "properties": {
        "string": {"type": "string", "title": "Some string"},
        "choice1": {"\$ref": "#/definitions/largeEnum"},
        "choice2": {"\$ref": "#/definitions/largeEnum"},
        "choice3": {"\$ref": "#/definitions/largeEnum"},
        "choice4": {"\$ref": "#/definitions/largeEnum"},
        "choice5": {"\$ref": "#/definitions/largeEnum"},
        "choice6": {"\$ref": "#/definitions/largeEnum"},
        "choice7": {"\$ref": "#/definitions/largeEnum"},
        "choice8": {"\$ref": "#/definitions/largeEnum"},
        "choice9": {"\$ref": "#/definitions/largeEnum"},
        "choice10": {"\$ref": "#/definitions/largeEnum"}
      }
    },
    "ui": {
      "choice1": {"ui:placeholder": "Choose one"}
    },
    "formData": {"": ""}
  };
  static Map<String, dynamic> dateTime = {
    "label": "Date-Time",
    "schema": {
      "title": "Date and time widgets",
      "type": "object",
      "properties": {
        "native": {
          "title": "Native",
          "description": "May not work on some browsers, notably Firefox Desktop and IE.",
          "type": "object",
          "properties": {
            "datetime": {"type": "string", "format": "date-time"},
            "date": {"type": "string", "format": "date"}
          }
        },
        "alternative": {
          "title": "Alternative",
          "description": "These work on most platforms.",
          "type": "object",
          "properties": {
            "alt-datetime": {"type": "string", "format": "date-time"},
            "alt-date": {"type": "string", "format": "date"}
          }
        }
      }
    },
    "ui": {
      "alternative": {
        "alt-datetime": {
          "ui:widget": "alt-datetime",
          "ui:options": {
            "yearsRange": [1980, 2030]
          }
        },
        "alt-date": {
          "ui:widget": "alt-date",
          "ui:options": {
            "yearsRange": [1980, 2030]
          }
        }
      }
    },
    "formData": {
      "native": {"": ""},
      "alternative": {"": ""}
    }
  };
  static Map<String, dynamic> validation = {
    "label": "Validation",
    "schema": {
      "title": "Custom validation",
      "description":
          "This form defines custom validation rules checking that the two passwords match.",
      "type": "object",
      "properties": {
        "pass1": {"title": "Password", "type": "string", "minLength": 3},
        "pass2": {"title": "Repeat password", "type": "string", "minLength": 3},
        "age": {"title": "Age", "type": "number", "minimum": 18}
      }
    },
    "ui": {
      "pass1": {"ui:widget": "password"},
      "pass2": {"ui:widget": "password"}
    },
    "formData": {"": ""}
  };
  static Map<String, dynamic> files = {
    "label": "Files",
    "schema": {
      "title": "Files",
      "type": "object",
      "properties": {
        "file": {"type": "string", "format": "data-url", "title": "Single file"},
        "files": {
          "type": "array",
          "title": "Multiple files",
          "items": {"type": "string", "format": "data-url"}
        },
        "filesAccept": {
          "type": "string",
          "format": "data-url",
          "title": "Single File with Accept attribute"
        }
      }
    },
    "ui": {
      "filesAccept": {
        "ui:options": {"accept": ".pdf"}
      }
    },
    "formData": {"": ""}
  };
  static Map<String, dynamic> single = {
    "label": "Single",
    "schema": {"title": "A single-field form", "type": "string"},
    "ui": {"": ""},
    "formData": "initial value"
  };
  static Map<String, dynamic> customArray = {
    "label": "Custom Array",
    "schema": {
      "title": "Custom array of strings",
      "type": "array",
      "items": {"type": "string"}
    },
    "ui": {"": ""},
    "formData": ["react", "jsonschema", "form"]
  };
  static Map<String, dynamic> customObject = {
    "label": "Custom Object",
    "schema": {
      "title": "A registration form",
      "description":
          "This is the same as the simple form, but it is rendered as a bootstrap grid. Try shrinking the browser window to see it in action.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {"type": "string", "title": "First name"},
        "lastName": {"type": "string", "title": "Last name"},
        "age": {"type": "integer", "title": "Age"},
        "bio": {"type": "string", "title": "Bio"},
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {"": ""},
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static Map<String, dynamic> alternatives = {
    "label": "Alternatives",
    "schema": {
      "definitions": {
        "Color": {
          "title": "Color",
          "type": "string",
          "anyOf": [
            {
              "type": "string",
              "enum": ["#ff0000"],
              "title": "Red"
            },
            {
              "type": "string",
              "enum": ["#00ff00"],
              "title": "Green"
            },
            {
              "type": "string",
              "enum": ["#0000ff"],
              "title": "Blue"
            }
          ]
        },
        "Toggle": {
          "title": "Toggle",
          "type": "boolean",
          "oneOf": [
            {"title": "Enable", "": true},
            {"title": "Disable", "": false}
          ]
        }
      },
      "title": "Image editor",
      "type": "object",
      "required": ["currentColor", "colorMask", "blendMode"],
      "properties": {
        "currentColor": {"\$ref": "#/definitions/Color", "title": "Brush color"},
        "colorMask": {
          "type": "array",
          "uniqueItems": true,
          "items": {"\$ref": "#/definitions/Color"},
          "title": "Color mask"
        },
        "toggleMask": {"title": "Apply color mask", "\$ref": "#/definitions/Toggle"},
        "colorPalette": {
          "type": "array",
          "title": "Color palette",
          "items": {"\$ref": "#/definitions/Color"}
        },
        "blendMode": {
          "title": "Blend mode",
          "type": "string",
          "enum": ["screen", "multiply", "overlay"],
          "enumNames": ["Screen", "Multiply", "Overlay"]
        }
      }
    },
    "ui": {
      "blendMode": {
        "ui:enumDisabled": ["multiply"]
      },
      "toggleMask": {"ui:widget": "radio"}
    },
    "formData": {
      "currentColor": "#00ff00",
      "colorMask": ["#0000ff"],
      "colorPalette": ["#ff0000"],
      "blendMode": "screen"
    }
  };
  static Map<String, dynamic> propertyDependencies = {
    "label": "Property Dependencies",
    "schema": {
      "title": "Property dependencies",
      "description": "These samples are best viewed without live validation.",
      "type": "object",
      "properties": {
        "unidirectional": {
          "title": "Unidirectional",
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"},
            "billing_address": {"type": "string"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": ["billing_address"]
          }
        },
        "bidirectional": {
          "title": "Bidirectional",
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "description":
              "Dependencies are not bidirectional, you can, of course, define the bidirectional dependencies explicitly.",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"},
            "billing_address": {"type": "string"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": ["billing_address"],
            "billing_address": ["credit_card"]
          }
        }
      }
    },
    "ui": {
      "unidirectional": {
        "credit_card": {
          "ui:help": "If you enter anything here then billing_address will become required."
        },
        "billing_address": {
          "ui:help": "It’s okay to have a billing address without a credit card number."
        }
      },
      "bidirectional": {
        "credit_card": {
          "ui:help": "If you enter anything here then billing_address will become required."
        },
        "billing_address": {
          "ui:help": "If you enter anything here then credit_card will become required."
        }
      }
    },
    "formData": {
      "unidirectional": {"name": "Tim"},
      "bidirectional": {"name": "Jill"}
    }
  };
  static Map<String, dynamic> schemaDependencies = {
    "label": "Schema Dependencies",
    "schema": {
      "title": "Schema dependencies",
      "description": "These samples are best viewed without live validation.",
      "type": "object",
      "properties": {
        "simple": {
          "src":
              "https://spacetelescope.github.io/understanding-json-schema/reference/object.html#dependencies",
          "title": "Simple",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "credit_card": {"type": "number"}
          },
          "required": ["name"],
          "dependencies": {
            "credit_card": {
              "properties": {
                "billing_address": {"type": "string"}
              },
              "required": ["billing_address"]
            }
          }
        },
        "conditional": {"title": "Conditional", "\$ref": "#/definitions/person"},
        "arrayOfConditionals": {
          "title": "Array of conditionals",
          "type": "array",
          "items": {"\$ref": "#/definitions/person"}
        },
        "fixedArrayOfConditionals": {
          "title": "Fixed array of conditionals",
          "type": "array",
          "items": [
            {"title": "Primary person", "\$ref": "#/definitions/person"}
          ],
          "additionalItems": {"title": "Additional person", "\$ref": "#/definitions/person"}
        }
      },
      "definitions": {
        "person": {
          "title": "Person",
          "type": "object",
          "properties": {
            "Do you have any pets?": {
              "type": "string",
              "enum": ["No", "Yes: One", "Yes: More than one"],
              "default": "No"
            }
          },
          "required": ["Do you have any pets?"],
          "dependencies": {
            "Do you have any pets?": {
              "oneOf": [
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["No"]
                    }
                  }
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: One"]
                    },
                    "How old is your pet?": {"type": "number"}
                  },
                  "required": ["How old is your pet?"]
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: More than one"]
                    },
                    "Do you want to get rid of any?": {"type": "boolean"}
                  },
                  "required": ["Do you want to get rid of any?"]
                }
              ]
            }
          }
        }
      }
    },
    "ui": {
      "simple": {
        "credit_card": {
          "ui:help":
              "If you enter anything here then billing_address will be dynamically added to the form."
        }
      },
      "conditional": {
        "Do you want to get rid of any?": {"ui:widget": "radio"}
      },
      "arrayOfConditionals": {
        "items": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        }
      },
      "fixedArrayOfConditionals": {
        "items": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        },
        "additionalItems": {
          "Do you want to get rid of any?": {"ui:widget": "radio"}
        }
      }
    },
    "formData": {
      "simple": {"name": "Randy"},
      "conditional": {"Do you have any pets?": "No"},
      "arrayOfConditionals": [
        {"Do you have any pets?": "Yes: One", "How old is your pet?": 6},
        {"Do you have any pets?": "Yes: More than one", "Do you want to get rid of any?": false}
      ],
      "fixedArrayOfConditionals": [
        {"Do you have any pets?": "No"},
        {"Do you have any pets?": "Yes: One", "How old is your pet?": 6},
        {"Do you have any pets?": "Yes: More than one", "Do you want to get rid of any?": true}
      ]
    }
  };
  static Map<String, dynamic> additionalProperties = {
    "label": "Additional Properties",
    "schema": {
      "title": "A customizable registration form",
      "description": "A simple form with additional properties example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "additionalProperties": {"type": "string"},
      "properties": {
        "firstName": {"type": "string", "title": "First name"},
        "lastName": {"type": "string", "title": "Last name"}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""}
    },
    "formData": {"firstName": "Chuck", "lastName": "Norris", "assKickCount": "infinity"}
  };
  static Map<String, dynamic> anyOf = {
    "label": "Any Of",
    "schema": {
      "type": "object",
      "properties": {
        "age": {"type": "integer", "title": "Age"},
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "anyOf": [
              {
                "properties": {
                  "foo": {"type": "string"}
                }
              },
              {
                "properties": {
                  "bar": {"type": "string"}
                }
              }
            ]
          }
        }
      },
      "anyOf": [
        {
          "title": "First method of identification",
          "properties": {
            "firstName": {"type": "string", "title": "First name", "default": "Chuck"},
            "lastName": {"type": "string", "title": "Last name"}
          }
        },
        {
          "title": "Second method of identification",
          "properties": {
            "idCode": {"type": "string", "title": "ID code"}
          }
        }
      ]
    },
    "ui": {"": ""},
    "formData": {"firstName": "Chuck"}
  };
  static Map<String, dynamic> oneOf = {
    "label": "One Of",
    "schema": {
      "type": "object",
      "oneOf": [
        {
          "properties": {
            "lorem": {"type": "string"}
          },
          "required": ["lorem"]
        },
        {
          "properties": {
            "ipsum": {"type": "string"}
          },
          "required": ["ipsum"]
        }
      ]
    },
    "ui": {"": ""},
    "formData": {"": ""}
  };
  static Map<String, dynamic> allOf = {
    "label": "All Of",
    "schema": {
      "type": "object",
      "allOf": [
        {
          "properties": {
            "lorem": {
              "type": ["string", "boolean"],
              "default": true
            }
          }
        },
        {
          "properties": {
            "lorem": {"type": "boolean"},
            "ipsum": {"type": "string"}
          }
        }
      ]
    },
    "ui": {"": ""},
    "formData": {"lorem": true}
  };
  static Map<String, dynamic> ifThenElse = {
    "label": "If Then Else",
    "schema": {
      "type": "object",
      "properties": {
        "animal": {
          "enum": ["Cat", "Fish"]
        }
      },
      "allOf": [
        {
          "if": {
            "properties": {
              "animal": {"": "Cat"}
            }
          },
          "then": {
            "properties": {
              "food": {
                "type": "string",
                "enum": ["meat", "grass", "fish"]
              }
            },
            "required": ["food"]
          }
        },
        {
          "if": {
            "properties": {
              "animal": {"": "Fish"}
            }
          },
          "then": {
            "properties": {
              "food": {
                "type": "string",
                "enum": ["insect", "worms"]
              },
              "water": {
                "type": "string",
                "enum": ["lake", "sea"]
              }
            },
            "required": ["food", "water"]
          }
        },
        {
          "required": ["animal"]
        }
      ]
    },
    "ui": {"": ""},
    "formData": {"": ""}
  };

  static Map<String, dynamic> nullFields = {
    "label": "Null Fields",
    "schema": {
      "title": "Null field example",
      "description": "A short form with a null field",
      "type": "object",
      "required": ["firstName"],
      "properties": {
        "helpText": {
          "title": "A null field",
          "description": "Null fields like this are great for adding extra information",
          "type": "null"
        },
        "firstName": {"type": "string", "title": "A regular string field", "default": "Chuck"}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""}
    },
    "formData": {"firstName": "Chuck"}
  };
  static Map<String, dynamic> nullable = {
    "label": "Nuallable",
    "schema": {
      "title": "A registration form (nullable)",
      "description": "A simple form example using nullable types",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {"type": "string", "title": "First name", "default": "Chuck"},
        "lastName": {"type": "string", "title": "Last name"},
        "age": {
          "type": ["integer", "null"],
          "title": "Age"
        },
        "bio": {
          "type": ["string", "null"],
          "title": "Bio"
        },
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)",
        "ui:emptyValue": null
      },
      "bio": {
        "ui:widget": "textarea",
        "ui:placeholder": "Leaving this field empty will cause formData property to be `null`",
        "ui:emptyValue": null
      },
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": null,
      "password": "noneed"
    }
  };
  static Map<String, dynamic> errorSchema = {
    "label": "Error Schema",
    "schema": {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {"type": "string", "title": "First name", "default": "Chuck"},
        "lastName": {"type": "string", "title": "Last name"},
        "age": {"type": "integer", "title": "Age"},
        "bio": {"type": "string", "title": "Bio"},
        "password": {"type": "string", "title": "Password", "minLength": 3},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10}
      }
    },
    "ui": {
      "firstName": {"ui:autofocus": true, "ui:emptyValue": ""},
      "age": {
        "ui:widget": "updown",
        "ui:title": "Age of person",
        "ui:description": "(earthian year)"
      },
      "bio": {"ui:widget": "textarea"},
      "password": {"ui:widget": "password", "ui:help": "Hint: Make it strong!"},
      "date": {"ui:widget": "alt-datetime"},
      "telephone": {
        "ui:options": {"inputType": "tel"}
      }
    },
    "formData": {
      "firstName": "Chuck",
      "lastName": "Norris",
      "age": 75,
      "bio": "Roundhouse kicking asses since 1940",
      "password": "noneed"
    }
  };
  static Map<String, dynamic> defaults = {
    "label": "Defaults",
    "schema": {
      "title": "Schema default properties",
      "type": "object",
      "properties": {
        "valuesInFormData": {
          "title": "Values in form data",
          "\$ref": "#/definitions/defaultsExample"
        },
        "noValuesInFormData": {
          "title": "No values in form data",
          "\$ref": "#/definitions/defaultsExample"
        }
      },
      "definitions": {
        "defaultsExample": {
          "type": "object",
          "properties": {
            "scalar": {"title": "Scalar", "type": "string", "default": "scalar default"},
            "array": {
              "title": "Array",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "nested": {
                    "title": "Nested array",
                    "type": "string",
                    "default": "nested array default"
                  }
                }
              }
            },
            "object": {
              "title": "Object",
              "type": "object",
              "properties": {
                "nested": {
                  "title": "Nested object",
                  "type": "string",
                  "default": "nested object default"
                }
              }
            }
          }
        }
      }
    },
    "ui": {"": ""},
    "formData": {
      "valuesInFormData": {
        "scalar": "value",
        "array": [
          {"nested": "nested array value"}
        ],
        "object": {"nested": "nested object value"}
      },
      "noValuesInFormData": {
        "scalar": "scalar default",
        "array": [
          {"nested": "nested array default"},
          {"nested": "nested array default"}
        ],
        "object": {"nested": "nested object default"}
      }
    }
  };

  static List<Map<String, dynamic>> schemas = [
    test,
    simple,
    nested,
    arrays,
    numbers,
    widgets,
    ordering,
    references,
    custom,
    errors,
    examples,
    large,
    dateTime,
    validation,
    files,
    single,
    customArray,
    customObject,
    alternatives,
    propertyDependencies,
    schemaDependencies,
    additionalProperties,
    anyOf,
    oneOf,
    allOf,
    ifThenElse,
    nullFields,
    nullable,
    errorSchema,
    defaults
  ];
}
