// src/data/zh.ts
import type { Content } from './types';

export const content: Content = {
  meta: {
    title: 'sm64coopdx Lua 脚本外挂',
    description: 'sm64coopdx 的 AGG / GG 修改器 Lua 脚本，包含作弊、监控、工具等。',
  },
  hero: {
    title: 'sm64coopdx Lua 脚本外挂',
    demoVideo: "/demo.mp4",
    subtitle:
      'AGG / GG 修改器专用 Lua 脚本，悬浮窗菜单，弹窗一键开关。快乐便捷草飞老外。',
  },
  nav: {
    howto: '如何使用',
    author: '作者',
    faq: '常见问题',
    langSwitch: 'English',
    screenshots: '截图',
  },
  download: {
    btn: '下载 .lua',
    version: 'v',
    updated: '更新于',
  },
  howto: {
    heading: '如何使用',
    steps: [
      {
        title: '安装',
        items: [
          '从上方下载对应的 .lua 脚本文件到手机。',
          '把文件放到手机存储的任意位置（记住路径）。',
          '打开 AGG 或 GG 修改器，允许悬浮窗权限。',
        ],
      },
      {
        title: '加载脚本',
        items: [
          '先启动 sm64coopdx，进入游戏。',
          '点击修改器悬浮窗图标，展开菜单。',
          '选择「执行脚本」或「加载 Lua」，找到刚才下载的 .lua 文件。',
          '确认执行，脚本菜单会显示在悬浮窗里。',
        ],
      },
      {
        title: '使用功能',
        items: [
          '点击悬浮窗内的功能名，切换开启 / 关闭状态。',
          '部分功能有数值选项（如飞行速度），按提示输入。',
          '退出游戏前建议先关闭所有功能，避免影响下次启动。',
        ],
      },
    ],
    notice:
      '注意：主脚本仅兼容 AGG 修改器（悬浮窗），不适用于 GameGuardian 等其他修改器。',
  },
  author: { heading: '作者' },
  faq: {
    heading: '常见问题',
    items: [
      {
        q: '需要 Root 吗？',
        a: '部分设备无需 Root，但搜索内存可能需要 Root 或虚拟空间。',
      },
      {
        q: '时间加速为什么不稳定？',
        a: '主脚本的时间加速会修改游戏的时间流速，部分场景可能导致卡顿或失效。',
      },
      {
        q: '脚本失效了怎么办？',
        a: '游戏更新后内存地址可能变化，需要等脚本更新。',
      },
      {
        q: '可以同时用多个脚本吗？',
        a: '可以，但功能重叠时可能冲突，建议按需加载。',
      },
    ],
  },
  gallery: {
    heading: '功能截图',
    subtitle: '游戏内实际效果展示。截图持续补充中。',
    empty: '目前还没有截图',
    backHome: '返回首页',
    screenshots: [
      {
        src: "main.jpg",
        title: "主脚本界面"
      },
      {
        src: "Screenshot_20261006_134753.jpg",
        title: "弹窗版本"
      },
      {
        src: "Screenshot_20261006_134854.jpg",
        title: "数据监控"
      },
      {
        src: "new_compoents.jpg",
        title: "Lua Component 版本 （新版）"
      }
    ],
  },
  footer: 'sm64coopdx Lua 脚本外挂 · 个人项目',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG 脚本合集',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: '一个 Lua 文件，集成多种作弊功能。',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: '仅兼容 AGG 修改器（悬浮窗）',
      features: [
        { name: 'Killaura', description: '自动攻击附近敌人，无需手动操作。' },
        { name: '空中飞行', description: '在空中自由飞行，穿墙探索地图边界。' },
        {
          name: '时间加速',
          description: '加速游戏内时间流动。不稳定，部分场景可能卡顿或失效。',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component 监控脚本',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description: '实时监控玩家状态、坐标、速度等信息，附带超强外观。',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: '马里奥状态显示',
          description: '实时显示当前马里奥的位置、速度、面向、动作。',
        },
        { name: 'Boss 监控', description: '显示 Boss 的血量。' },
      ],
    },
    {
      id: 'orig',
      name: '弹窗式外挂',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description: '同时兼容两个修改器版本的外挂，弹窗式原始版本。',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG 修改器',
    },
    {
      id: 'misc',
      name: '散装外挂合集',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description: '不是脚本，而是直接导入到 GG 修改器的内存基址数据，可任意修改。',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG 修改器',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (主要 Lua 开发)',
      bio: 'sm64coopdx 玩家，国内被 coopnet 封禁第一人',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'B站', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (辅助 / Derect Client 开发)',
      bio: '比狗哥收敛点，最早脚本的框架构成',
      avatar: '/toad.jpg',
      links: [
        { label: 'B站', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};
