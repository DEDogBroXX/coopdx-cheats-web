// src/data/pt.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx scripts Lua',
    description:
      'Scripts Lua para sm64coopdx no AGG / GG. Cheats, monitoramento e utilitários.',
  },
  hero: {
    title: 'sm64coopdx scripts Lua',
    subtitle:
      'Scripts Lua para AGG / GG. Menu em janela flutuante, alternância com um toque.',
  },
  nav: {
    howto: 'Como usar',
    author: 'Autores',
    faq: 'Perguntas frequentes',
    langSwitch: 'Português',
  },
  download: {
    btn: 'Baixar .lua',
    version: 'v',
    updated: 'Atualizado',
  },
  howto: {
    heading: 'Como usar',
    steps: [
      {
        title: 'Instalação',
        items: [
          'Baixe o arquivo <code>.lua</code> na seção acima.',
          'Coloque o arquivo em qualquer lugar do seu celular (lembre-se do caminho).',
          'Abra o <strong>AGG ou GG</strong> e conceda permissão de janela flutuante.',
        ],
      },
      {
        title: 'Carregar o script',
        items: [
          'Primeiro, inicie o sm64coopdx e entre no jogo.',
          'Toque no ícone da janela flutuante para abrir o menu.',
          'Escolha «Executar script» ou «Carregar Lua» e localize o arquivo <code>.lua</code> baixado.',
          'Confirme a execução. O menu do script aparecerá na janela flutuante.',
        ],
      },
      {
        title: 'Usar as funções',
        items: [
          'Toque no nome de uma função para ativá-la / desativá-la.',
          'Algumas funções têm opções numéricas (ex.: velocidade de voo) — insira os valores conforme solicitado.',
          'Desative todas as funções antes de sair do jogo para evitar problemas na próxima inicialização.',
        ],
      },
    ],
    notice:
      'Aviso: o script principal é <strong>exclusivo para AGG (janela flutuante)</strong>. Não funciona com GameGuardian ou outras ferramentas.',
  },
  author: { heading: 'Autores' },
  faq: {
    heading: 'Perguntas frequentes',
    items: [
      {
        q: 'Preciso de root?',
        a: 'Alguns dispositivos funcionam sem root, mas a busca na memória pode exigir root ou espaço virtual.',
      },
      {
        q: 'Por que a velocidade do tempo é instável?',
        a: 'A velocidade do tempo do script principal modifica o fluxo do tempo do jogo. Algumas cenas podem travar ou falhar.',
      },
      {
        q: 'O script parou de funcionar. O que fazer?',
        a: 'Os endereços de memória podem mudar após uma atualização do jogo. Aguarde uma atualização do script.',
      },
      {
        q: 'Posso usar vários scripts ao mesmo tempo?',
        a: 'Sim, mas funções que se sobrepõem podem conflitar. Carregue apenas o que precisar.',
      },
    ],
  },
  footer: 'sm64coopdx scripts Lua · Projeto pessoal',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx coleção AGG',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'Um único arquivo Lua com várias funções de cheat.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'Somente AGG (janela flutuante)',
      features: [
        {
          name: 'Killaura',
          description: 'Ataca automaticamente inimigos próximos.',
        },
        {
          name: 'Voo',
          description: 'Voe livremente pelo ar, atravesse paredes.',
        },
        {
          name: 'Velocidade do tempo',
          description:
            'Acelera o tempo do jogo. Instável — pode travar ou falhar em algumas cenas.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component monitor',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'Monitoramento em tempo real do estado, posição e velocidade do jogador. Com um HUD poderoso.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'Status do Mario',
          description:
            'Mostra a posição, velocidade, direção e ação do Mario em tempo real.',
        },
        {
          name: 'Monitor de chefe',
          description: 'Mostra o HP do chefe.',
        },
      ],
    },
    {
      id: 'orig',
      name: 'Cheat estilo diálogo',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'Cheat original estilo diálogo, compatível com AGG e GG.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'Coleção de cheats variados',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'Não é um script — dados de endereço base de memória importados diretamente no GG. Modifique o que quiser.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (Desenvolvedor principal Lua)',
      bio: 'Jogador de sm64coopdx. Primeira pessoa banida do coopnet na China.',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (Auxiliar / desenvolvedor do Derect Client)',
      bio: 'Mais reservado que o DogBro. Construiu o framework inicial dos scripts.',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};