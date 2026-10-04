// src/data/de.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx Lua-Skripte',
    description:
      'Lua-Skripte für sm64coopdx auf AGG / GG. Cheats, Monitoring und Tools.',
  },
  hero: {
    title: 'sm64coopdx Lua-Skripte',
    subtitle:
      'Lua-Skripte für AGG / GG. Menü im schwebenden Fenster, Umschalten per Tipp.',
  },
  nav: {
    howto: 'Anleitung',
    author: 'Autoren',
    faq: 'FAQ',
    langSwitch: 'Deutsch',
  },
  download: {
    btn: '.lua herunterladen',
    version: 'v',
    updated: 'Aktualisiert',
  },
  howto: {
    heading: 'Anleitung',
    steps: [
      {
        title: 'Installation',
        items: [
          'Lade die <code>.lua</code>-Datei aus dem Abschnitt oben herunter.',
          'Lege die Datei an einen beliebigen Ort auf deinem Handy (merke dir den Pfad).',
          'Öffne <strong>AGG oder GG</strong> und erlaube den Zugriff auf das schwebende Fenster.',
        ],
      },
      {
        title: 'Skript laden',
        items: [
          'Starte zuerst sm64coopdx und betrete das Spiel.',
          'Tippe auf das Symbol des schwebenden Fensters, um das Menü zu öffnen.',
          'Wähle „Skript ausführen" oder „Lua laden" und suche die heruntergeladene <code>.lua</code>-Datei.',
          'Bestätige die Ausführung. Das Skriptmenü erscheint im schwebenden Fenster.',
        ],
      },
      {
        title: 'Funktionen nutzen',
        items: [
          'Tippe auf einen Funktionsnamen, um ihn ein- / auszuschalten.',
          'Einige Funktionen haben Zahlenwerte (z. B. Fluggeschwindigkeit) — gib die Werte wie aufgefordert ein.',
          'Deaktiviere alle Funktionen vor dem Beenden des Spiels, um Probleme beim nächsten Start zu vermeiden.',
        ],
      },
    ],
    notice:
      'Hinweis: Das Hauptskript ist <strong>nur für AGG (schwebendes Fenster)</strong>. Es funktioniert nicht mit GameGuardian oder anderen Tools.',
  },
  author: { heading: 'Autoren' },
  faq: {
    heading: 'FAQ',
    items: [
      {
        q: 'Brauche ich Root?',
        a: 'Einige Geräte funktionieren ohne Root, aber das Durchsuchen des Speichers kann Root oder einen virtuellen Bereich erfordern.',
      },
      {
        q: 'Warum ist die Zeitgeschwindigkeit instabil?',
        a: 'Die Zeitgeschwindigkeit des Hauptskripts verändert den Zeitfluss im Spiel. In manchen Szenen kann es ruckeln oder fehlschlagen.',
      },
      {
        q: 'Das Skript funktioniert nicht mehr. Was nun?',
        a: 'Nach einem Spiel-Update können sich Speicheradressen ändern. Warte auf ein Skript-Update.',
      },
      {
        q: 'Kann ich mehrere Skripte gleichzeitig nutzen?',
        a: 'Ja, aber überlappende Funktionen können sich gegenseitig stören. Lade nur, was du brauchst.',
      },
    ],
  },
  footer: 'sm64coopdx Lua-Skripte · Privates Projekt',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG-Sammlung',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'Eine einzelne Lua-Datei mit mehreren Cheat-Funktionen.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'Nur AGG (schwebendes Fenster)',
      features: [
        {
          name: 'Killaura',
          description: 'Greift nahe Gegner automatisch an.',
        },
        {
          name: 'Fliegen',
          description: 'Frei durch die Luft fliegen, durch Wände gehen.',
        },
        {
          name: 'Zeitgeschwindigkeit',
          description:
            'Beschleunigt die Spielzeit. Instabil — in manchen Szenen kann es ruckeln oder fehlschlagen.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component Monitor',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'Echtzeit-Überwachung von Spielerstatus, Position und Geschwindigkeit. Mit starkem HUD.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'Mario-Statusanzeige',
          description:
            'Zeigt Position, Geschwindigkeit, Blickrichtung und Aktion von Mario in Echtzeit.',
        },
        {
          name: 'Boss-Monitor',
          description: 'Zeigt die HP des Bosses.',
        },
      ],
    },
    {
      id: 'orig',
      name: 'Dialog-Cheat',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'Originaler Dialog-Cheat, kompatibel mit AGG und GG.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'Verschiedene Cheats',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'Kein Skript — Basisadressdaten, die direkt in GG importiert werden. Ändere alles.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (Hauptentwickler Lua)',
      bio: 'sm64coopdx-Spieler. Erste Person, die in China von coopnet gebannt wurde.',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (Helfer / Derect Client Entwickler)',
      bio: 'Zurückhaltender als DogBro. Baute das frühe Skript-Framework.',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};