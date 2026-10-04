// src/data/fr.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx scripts Lua',
    description:
      'Scripts Lua pour sm64coopdx sur AGG / GG. Triches, surveillance et outils.',
  },
  hero: {
    title: 'sm64coopdx scripts Lua',
    subtitle:
      'Scripts Lua pour AGG / GG. Menu en fenêtre flottante, activation en un tap.',
  },
  nav: {
    howto: 'Utilisation',
    author: 'Auteurs',
    faq: 'FAQ',
    langSwitch: 'Français',
  },
  download: {
    btn: 'Télécharger .lua',
    version: 'v',
    updated: 'Mis à jour',
  },
  howto: {
    heading: 'Utilisation',
    steps: [
      {
        title: 'Installation',
        items: [
          'Téléchargez le fichier <code>.lua</code> depuis la section ci-dessus.',
          'Placez le fichier n\'importe où sur votre téléphone (retenez le chemin).',
          'Ouvrez <strong>AGG ou GG</strong> et autorisez la fenêtre flottante.',
        ],
      },
      {
        title: 'Charger le script',
        items: [
          'Lancez d\'abord sm64coopdx et entrez dans le jeu.',
          'Touchez l\'icône de la fenêtre flottante pour ouvrir le menu.',
          'Choisissez « Exécuter le script » ou « Charger Lua » et localisez le fichier <code>.lua</code> téléchargé.',
          'Confirmez l\'exécution. Le menu du script apparaîtra dans la fenêtre flottante.',
        ],
      },
      {
        title: 'Utiliser les fonctions',
        items: [
          'Touchez le nom d\'une fonction pour l\'activer / la désactiver.',
          'Certaines fonctions ont des options numériques (ex. vitesse de vol) — saisissez les valeurs demandées.',
          'Désactivez toutes les fonctions avant de quitter le jeu pour éviter tout problème au prochain lancement.',
        ],
      },
    ],
    notice:
      'Attention : le script principal est <strong>uniquement pour AGG (fenêtre flottante)</strong>. Il ne fonctionne pas avec GameGuardian ou d\'autres outils.',
  },
  author: { heading: 'Auteurs' },
  faq: {
    heading: 'FAQ',
    items: [
      {
        q: 'Ai-je besoin du root ?',
        a: 'Certains appareils fonctionnent sans root, mais la recherche en mémoire peut nécessiter le root ou un espace virtuel.',
      },
      {
        q: 'Pourquoi la vitesse du temps est-elle instable ?',
        a: 'La vitesse du temps du script principal modifie le flux temporel du jeu. Certaines scènes peuvent saccader ou échouer.',
      },
      {
        q: 'Le script ne fonctionne plus. Que faire ?',
        a: 'Les adresses mémoire peuvent changer après une mise à jour du jeu. Attendez une mise à jour du script.',
      },
      {
        q: 'Puis-je utiliser plusieurs scripts à la fois ?',
        a: 'Oui, mais les fonctions qui se chevauchent peuvent entrer en conflit. Ne chargez que ce dont vous avez besoin.',
      },
    ],
  },
  footer: 'sm64coopdx scripts Lua · Projet personnel',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx collection AGG',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'Un seul fichier Lua avec plusieurs fonctions de triche.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'AGG uniquement (fenêtre flottante)',
      features: [
        {
          name: 'Killaura',
          description: 'Attaque automatiquement les ennemis proches.',
        },
        {
          name: 'Vol',
          description: 'Voler librement dans les airs, traverser les murs.',
        },
        {
          name: 'Vitesse du temps',
          description:
            'Accélère le temps du jeu. Instable — peut saccader ou échouer dans certaines scènes.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component moniteur',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'Surveillance en temps réel de l\'état, la position et la vitesse du joueur. Avec un HUD puissant.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'État de Mario',
          description:
            'Affiche la position, la vitesse, l\'orientation et l\'action de Mario en temps réel.',
        },
        {
          name: 'Moniteur de boss',
          description: 'Affiche les PV du boss.',
        },
      ],
    },
    {
      id: 'orig',
      name: 'Triche style dialogue',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'Triche originale style dialogue, compatible avec AGG et GG.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'Collection de triches diverses',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'Pas un script — données d\'adresses de base mémoire importées directement dans GG. Modifiez tout.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (Développeur Lua principal)',
      bio: 'Joueur de sm64coopdx. Première personne bannie de coopnet en Chine.',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (Assistant / développeur Derect Client)',
      bio: 'Plus discret que DogBro. A construit le premier framework de scripts.',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};