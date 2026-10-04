// src/data/ja.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx Lua スクリプト',
    description:
      'sm64coopdx 用の AGG / GG チート用 Lua スクリプト。チート、監視、ツールなどを収録。',
  },
  hero: {
    title: 'sm64coopdx Lua スクリプト',
    subtitle:
      'AGG / GG 専用の Lua スクリプト。フローティングウィンドウのメニューからワンタップで切替。',
  },
  nav: {
    howto: '使い方',
    author: '作者',
    faq: 'よくある質問',
    langSwitch: '日本語',
  },
  download: {
    btn: '.lua をダウンロード',
    version: 'v',
    updated: '更新日',
  },
  howto: {
    heading: '使い方',
    steps: [
      {
        title: 'インストール',
        items: [
          '上のセクションから <code>.lua</code> ファイルをダウンロードします。',
          'ファイルをスマホの任意の場所に保存します（パスを覚えておいてください）。',
          '<strong>AGG または GG</strong> を起動し、フローティングウィンドウの権限を許可します。',
        ],
      },
      {
        title: 'スクリプトを読み込む',
        items: [
          '先に sm64coopdx を起動してゲームに入ります。',
          'フローティングウィンドウのアイコンをタップしてメニューを開きます。',
          '「スクリプトを実行」または「Lua を読み込む」を選び、先ほどダウンロードした <code>.lua</code> ファイルを指定します。',
          '実行を確認すると、スクリプトメニューがフローティングウィンドウに表示されます。',
        ],
      },
      {
        title: '機能を使う',
        items: [
          '機能名をタップしてオン / オフを切り替えます。',
          '一部の機能には数値オプション（飛行速度など）があります。指示に従って入力してください。',
          'ゲームを終了する前にすべての機能をオフにすることをおすすめします。',
        ],
      },
    ],
    notice:
      '注意：メインスクリプトは <strong>AGG 専用（フローティングウィンドウ）</strong> です。GameGuardian など他のツールでは動作しません。',
  },
  author: { heading: '作者' },
  faq: {
    heading: 'よくある質問',
    items: [
      {
        q: 'Root は必要ですか？',
        a: '一部の端末では Root なしでも動作しますが、メモリ検索には Root または仮想空間が必要な場合があります。',
      },
      {
        q: '時間加速が不安定なのはなぜですか？',
        a: 'メインスクリプトの時間加速はゲーム内の時間の流れを変更するため、シーンによってはカクついたり動作しなくなったりします。',
      },
      {
        q: 'スクリプトが動かなくなりました。',
        a: 'ゲームのアップデートでメモリアドレスが変わることがあります。スクリプトの更新をお待ちください。',
      },
      {
        q: '複数のスクリプトを同時に使えますか？',
        a: '可能ですが、機能が重複すると競合する場合があります。必要なものだけを読み込んでください。',
      },
    ],
  },
  footer: 'sm64coopdx Lua スクリプト · 個人プロジェクト',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG スクリプト集',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: '複数のチート機能を 1 つの Lua ファイルにまとめたもの。',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'AGG 専用（フローティングウィンドウ）',
      features: [
        {
          name: 'Killaura',
          description: '近くの敵を自動で攻撃します。手動操作は不要。',
        },
        {
          name: '空中飛行',
          description: '空中を自由に飛び、壁をすり抜けてマップの外まで探索できます。',
        },
        {
          name: '時間加速',
          description:
            'ゲーム内の時間を加速します。不安定で、シーンによってはカクついたり無効になったりします。',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component 監視スクリプト',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'プレイヤーの状態、座標、速度などをリアルタイムで監視。強力な HUD 付き。',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'マリオの状態表示',
          description:
            '現在のマリオの位置、速度、向き、アクションをリアルタイムで表示します。',
        },
        {
          name: 'ボス監視',
          description: 'ボスの HP を表示します。',
        },
      ],
    },
    {
      id: 'orig',
      name: 'ダイアログ式チート',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'AGG と GG の両方に対応した、オリジナルのダイアログ式チート。',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'その他チート詰め合わせ',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'スクリプトではなく、GG に直接インポートするメモリのベースアドレスデータ。自由に改造できます。',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (メイン Lua 開発)',
      bio: 'sm64coopdx プレイヤー。中国で coopnet から BAN された第一人者。',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (補助 / Derect Client 開発)',
      bio: '狗哥よりは控えめ。初期スクリプトのフレームワークを構築。',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};