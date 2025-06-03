

import 'dart:math';

import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestDemoButton extends StatelessWidget {
  const TestDemoButton({super.key});

  static final map = {
    'title': 'Quiz 1',
    'description': 'PACIENTE de 55 ANOS, DEU ENTRADA NO PS TRAZIDA PELA AMBULÂNCIA, COM QUADRO DE DISPNEIA, FEBRE E TOSSE HÁ 3 DIAS, COM PIORA DOS SINTOMAS NAS ÚLTIMAS 24 HORAS. REFERE SER DIABÉTICA EM TRATAMENTO COM HIPOGLICEMIANTES ORAIS. NEGA ALERGIAS. A ENFERMEIRA JÁ MONITORIZOU E PROVIDENCIOU UM ACESSO VENOSO. VOCÊ É O PLANTONISTA RESPONSÁVEL. E ELA O CHAMOU PARA AJUDAR. ',
    'statusList' : [
      {   'measures': [
        {
          'display': 'sat', 'levels': Random().nextDouble()/2 + 1.3
        }
      ] },
      {
        'measures': [
          {
            'display': 'sat', 'levels': Random().nextDouble()/2 + 0.3
          }
        ]
      }
    ],
    'questions': [
      {
        'id': 0,
        'orderValue': 3,
        'description': 'QUÃO EMERGENCIAL É ESSA SITUAÇÃO?',
        'options': [

          {'description': 'MUITO EMERGENCIAL', 'is_correct': 1, },
          {'description': 'MODERADAMENTE EMERGENCIAL', 'is_correct': 0, },
          {'description': 'POUCO EMERGENCIAL', 'is_correct': 0, },
        ],
        'isFinal': false
      },
      {
        'id': 1,
        'orderValue': 1,
        'update': {
          'status': 1,
        },
        'description': 'QUÃO DIFÍCIL PODE SER O MANUSEIO DA VIA AÉREA NESSE CASO?',
        'options': [
          {'description': 'NÃO HÁ FATORES PREDITIVOS', 'is_correct': 0,
          },
          {'description': 'SERÁ MUITO DIFÍCIL', 'is_correct': 1},
          {'description': 'PODE SER MODERADAMENTE DIFÍCIL', 'is_correct': 0},
        ],
        'isFinal': false
      },
      {
        'id': 2,
        'orderValue': 2,
        'description': 'QUAL SUA OPÇÃO DE ESCOLHA?',
        'options': [
          {'description': 'AGUARDAR POR AJUDA', 'is_correct': 0,
          },
          {'description': 'VENTILAÇÃO COM AMBU E MÁSCARA FACIAL', 'is_correct': 1},
          {'description': 'INTUBAÇÃO OROTRAQUEAL', 'is_correct': 0},
        ],
        'isFinal': false
      },
      {
        'id': 2,
        'orderValue': 2,
        'description': 'QUAL TÉCNICA PARA REALIZAR A IOT VOCÊ UTILIZARIA?',
        'options': [
          {'description': 'SEDAÇÃO LEVE COM MIDAZOLAM E FENTANIL', 'is_correct': 0,
          },
          {'description': 'SEQUÊNCIA RÁPIDA DE INTUBAÇÃO', 'is_correct': 1},
          {'description': 'SEDAÇÃO COM PROPOFOL E LIDOCAINA', 'is_correct': 0},
        ],
        'isFinal': true
      },

    ]
  };

  @override
  Widget build(BuildContext context) {
    return Container();
    return CardButtonV1(
      width: CardDimension(
        itemSize: ItemSize.large
      ),
      title: CardTextContent(
      content: 'Demonstração',
    ),
      onPress: (){


        /**
            final map = {
            'title': 'Quiz Teste 3',
            'description': 'Quiz Teste 3',
            'statusList' : [
            {   'measures': [
            {
            'display': 'sat', 'levels': Random().nextDouble()/2 + 1.3
            }
            ] },
            {
            'measures': [
            {
            'display': 'sat', 'levels': Random().nextDouble()/2 + 0.3
            }
            ]
            }
            ],
            'questions': [
            {
            'id': 0,
            'orderValue': 3,
            'description': 'Questão 1',
            'options': [
            {'description': 'Opção 1', 'is_correct': 1,
            'next_question_map': {
            'default': 2,
            'slow':3
            }},
            {'description': 'Opção 2', 'is_correct': 0,'next_question_id': 1},
            {'description': 'Opção 3', 'is_correct': 0,'next_question_id': 1},
            {'description': 'Opção 4', 'is_correct': 0, 'next_question_id': 1},
            ],
            'isFinal': false
            },
            {
            'id': 1,
            'orderValue': 1,
            'update': {
            'status': 1,
            },
            'description': 'Questão 2',
            'options': [
            {'description': 'Opção 1', 'is_correct': 0,
            },
            {'description': 'Opção 2', 'is_correct': 1},
            {'description': 'Opção 3', 'is_correct': 0},
            {'description': 'Opção 4', 'is_correct': 0},
            ],
            'isFinal': true
            },
            {
            'id': 2,
            'orderValue': 2,
            'description': 'Questão 3',
            'options': [
            {'description': 'Opção 1', 'is_correct': 0,
            },
            {'description': 'Opção 2', 'is_correct': 1},
            {'description': 'Opção 3', 'is_correct': 0},
            {'description': 'Opção 4', 'is_correct': 0},
            ],
            'isFinal': true
            },
            {
            'id': 3,
            'orderValue': 3,
            'description': 'Questão 4',
            'options': [
            {'description': 'Opção 1', 'is_correct': 0,
            },
            {'description': 'Opção 2', 'is_correct': 1},
            {'description': 'Opção 3', 'is_correct': 0},
            {'description': 'Opção 4', 'is_correct': 0},
            ],
            'isFinal': true
            },
            ]
            };
         */
        /*
        context.push(
            GameQuizRoute().routePath,
            extra: {
              'quiz': Quiz.createQuizFromData(map),
              'isTutorial': true
            }
        );*/
      },
      //backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
