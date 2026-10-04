// src/data/es.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx scripts Lua',
    description:
      'Scripts Lua para sm64coopdx en AGG / GG. Trucos, monitoreo y utilidades.',
  },
  hero: {
    title: 'sm64coopdx scripts Lua',
    subtitle:
      'Scripts Lua para AGG / GG. Menú en ventana flotante, interruptores con un toque.',
  },
  nav: {
    howto: 'Cómo usar',
    author: 'Autores',
    faq: 'Preguntas frecuentes',
    langSwitch: 'Español',
  },
  download: {
    btn: 'Descargar .lua',
    version: 'v',
    updated: 'Actualizado',
  },
  howto: {
    heading: 'Cómo usar',
    steps: [
      {
        title: 'Instalación',
        items: [
          'Descarga el archivo <code>.lua</code> desde la sección de arriba.',
          'Coloca el archivo en cualquier lugar de tu teléfono (recuerda la ruta).',
          'Abre <strong>AGG o GG</strong> y concede el permiso de ventana flotante.',
        ],
      },
      {
        title: 'Cargar el script',
        items: [
          'Primero inicia sm64coopdx y entra al juego.',
          'Toca el icono de la ventana flotante para abrir el menú.',
          'Elige «Ejecutar script» o «Cargar Lua» y busca el archivo <code>.lua</code> descargado.',
          'Confirma la ejecución. El menú del script aparecerá en la ventana flotante.',
        ],
      },
      {
        title: 'Usar las funciones',
        items: [
          'Toca el nombre de una función para activarla o desactivarla.',
          'Algunas funciones tienen opciones numéricas (por ejemplo, velocidad de vuelo) — introduce los valores cuando se te pida.',
          'Desactiva todas las funciones antes de salir del juego para evitar problemas en el próximo inicio.',
        ],
      },
    ],
    notice:
      'Aviso: el script principal es <strong>solo para AGG (ventana flotante)</strong>. No funciona con GameGuardian ni otras herramientas.',
  },
  author: { heading: 'Autores' },
  faq: {
    heading: 'Preguntas frecuentes',
    items: [
      {
        q: '¿Necesito Root?',
        a: 'Algunos dispositivos funcionan sin Root, pero buscar en la memoria puede requerir Root o un espacio virtual.',
      },
      {
        q: '¿Por qué la velocidad del tiempo es inestable?',
        a: 'La velocidad del tiempo del script principal modifica el flujo del tiempo del juego. Algunas escenas pueden dar tirones o fallar.',
      },
      {
        q: 'El script dejó de funcionar. ¿Qué hago?',
        a: 'Las direcciones de memoria pueden cambiar tras una actualización del juego. Espera a que el script se actualice.',
      },
      {
        q: '¿Puedo usar varios scripts a la vez?',
        a: 'Sí, pero las funciones que se solapan pueden entrar en conflicto. Carga solo lo que necesites.',
      },
    ],
  },
  footer: 'sm64coopdx scripts Lua · Proyecto personal',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx colección AGG',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'Un solo archivo Lua con varias funciones de trucos.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'Solo AGG (ventana flotante)',
      features: [
        {
          name: 'Killaura',
          description: 'Ataca automáticamente a los enemigos cercanos.',
        },
        {
          name: 'Vuelo',
          description: 'Vuela libremente por el aire, atraviesa paredes.',
        },
        {
          name: 'Velocidad del tiempo',
          description:
            'Acelera el tiempo del juego. Inestable — puede dar tirones o fallar en algunas escenas.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component monitor',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'Monitoreo en tiempo real del estado, posición y velocidad del jugador. Con un HUD potente.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'Estado de Mario',
          description:
            'Muestra la posición, velocidad, orientación y acción de Mario en tiempo real.',
        },
        {
          name: 'Monitor del jefe',
          description: 'Muestra la vida del jefe.',
        },
      ],
    },
    {
      id: 'orig',
      name: 'Truco estilo diálogo',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'Truco original estilo diálogo, compatible con AGG y GG.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'Colección de trucos varios',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'No es un script — son datos de direcciones base de memoria que se importan directamente en GG. Modifica lo que quieras.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (Desarrollador principal de Lua)',
      bio: 'Jugador de sm64coopdx. Primera persona baneada de coopnet en China.',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (Ayudante / desarrollador de Derect Client)',
      bio: 'Más reservado que DogBro. Construyó el marco inicial de los scripts.',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};