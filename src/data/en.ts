// src/data/en.ts
import type { Content } from './types';

export const content: Content = {
  meta: {
    title: 'sm64coopdx Lua Scripts',
    description:
      'Lua scripts for sm64coopdx on AGG / GG. Cheats, monitoring, and utility tools.',
  },
  hero: {
    title: 'sm64coopdx Lua Scripts',
    subtitle:
      'Lua scripts for AGG / GG. Floating window menu, one-tap toggles. Have fun.',
  },
  nav: {
    howto: 'How to Use',
    author: 'Authors',
    faq: 'FAQ',
    screenshots: 'Screenshots',
    langSwitch: '中文',
  },
  download: {
    btn: 'Download .lua',
    version: 'v',
    updated: 'Updated',
  },
  howto: {
    heading: 'How to Use',
    steps: [
      {
        title: 'Install',
        items: [
          'Download the .lua file from the section above.',
          'Place the file anywhere on your phone storage (remember the path).',
          'Open AGG or GG and grant floating window permission.',
        ],
      },
      {
        title: 'Load the Script',
        items: [
          'Launch sm64coopdx and enter the game.',
          'Tap the floating window icon to open the menu.',
          'Choose "Run Script" or "Load Lua" and locate the downloaded .lua file.',
          'Confirm to execute. The script menu will appear in the floating window.',
        ],
      },
      {
        title: 'Use Features',
        items: [
          'Tap a feature name to toggle it on / off.',
          'Some features have numeric options (e.g. fly speed) — enter values as prompted.',
          'Turn off all features before exiting the game to avoid issues on next launch.',
        ],
      },
    ],
    notice:
      'Note: the main script is AGG-only (floating window). It does not work with GameGuardian or other tools.',
  },
  author: { heading: 'Authors' },
  faq: {
    heading: 'FAQ',
    items: [
      {
        q: 'Do I need root?',
        a: 'Some devices work without root, but memory scanning may require root or a virtual space.',
      },
      {
        q: 'Why is time speed unstable?',
        a: "The main script's time speed modifies the game's time flow. Some scenes may stutter or break.",
      },
      {
        q: 'The script stopped working. What now?',
        a: 'Memory addresses may change after a game update. Wait for a script update.',
      },
      {
        q: 'Can I use multiple scripts at once?',
        a: 'Yes, but overlapping features may conflict. Load only what you need.',
      },
    ],
  },
  gallery: {
    heading: 'Screenshots',
    subtitle: 'Actual in-game effects. More screenshots coming soon.',
    empty: 'No screenshots yet',
    backHome: 'Back to home',
    screenshots: [],
  },
  footer: 'sm64coopdx Lua Scripts · Personal project',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG Script Collection',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'A single Lua file with multiple cheat features.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'AGG only (floating window)',
      features: [
        { name: 'Killaura', description: 'Automatically attack nearby enemies.' },
        { name: 'Fly', description: 'Fly freely in the air, pass through walls.' },
        {
          name: 'Time Speed',
          description:
            'Speeds up in-game time. Unstable — may stutter or break in some scenes.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component Monitor',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'Real-time monitoring of player state, position, and speed. Comes with a powerful HUD.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'Mario Status Display',
          description: "Shows Mario's position, speed, facing, and action in real time.",
        },
        { name: 'Boss Monitor', description: "Shows the boss's HP." },
      ],
    },
    {
      id: 'orig',
      name: 'Dialog Style Cheat',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'Original dialog-style cheat, compatible with both AGG and GG.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'Misc Cheat Collection',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'Not a script — memory base address data imported directly into GG. Modify anything.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (Main Lua developer)',
      bio: 'sm64coopdx player. First person banned from coopnet in China.',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (Helper / Derect Client developer)',
      bio: 'More reserved than DogBro. Built the earliest script framework.',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};