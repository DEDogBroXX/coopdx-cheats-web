// src/data/ko.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx Lua 스크립트',
    description:
      'sm64coopdx용 AGG / GG Lua 스크립트. 치트, 모니터링, 유틸리티.',
  },
  hero: {
    title: 'sm64coopdx Lua 스크립트',
    subtitle:
      'AGG / GG 전용 Lua 스크립트. 플로팅 윈도우 메뉴, 한 번의 탭으로 전환.',
  },
  nav: {
    howto: '사용 방법',
    author: '제작자',
    faq: '자주 묻는 질문',
    langSwitch: '한국어',
  },
  download: {
    btn: '.lua 다운로드',
    version: 'v',
    updated: '업데이트',
  },
  howto: {
    heading: '사용 방법',
    steps: [
      {
        title: '설치',
        items: [
          '위 섹션에서 <code>.lua</code> 파일을 다운로드하세요.',
          '파일을 휴대폰의 아무 위치에나 저장하세요 (경로를 기억해 두세요).',
          '<strong>AGG 또는 GG</strong>를 열고 플로팅 윈도우 권한을 허용하세요.',
        ],
      },
      {
        title: '스크립트 불러오기',
        items: [
          '먼저 sm64coopdx를 실행하고 게임에 들어갑니다.',
          '플로팅 윈도우 아이콘을 탭해 메뉴를 엽니다.',
          '«스크립트 실행» 또는 «Lua 불러오기»를 선택하고 방금 다운로드한 <code>.lua</code> 파일을 찾습니다.',
          '실행을 확인하면 스크립트 메뉴가 플로팅 윈도우에 표시됩니다.',
        ],
      },
      {
        title: '기능 사용',
        items: [
          '기능 이름을 탭해 켜기 / 끄기를 전환합니다.',
          '일부 기능에는 숫자 옵션(예: 비행 속도)이 있습니다 — 안내에 따라 값을 입력하세요.',
          '게임을 종료하기 전에 모든 기능을 꺼 두면 다음 실행에 문제가 없습니다.',
        ],
      },
    ],
    notice:
      '주의: 메인 스크립트는 <strong>AGG 전용 (플로팅 윈도우)</strong>입니다. GameGuardian 등 다른 도구에서는 작동하지 않습니다.',
  },
  author: { heading: '제작자' },
  faq: {
    heading: '자주 묻는 질문',
    items: [
      {
        q: '루트가 필요한가요?',
        a: '일부 기기는 루트 없이 작동하지만, 메모리 검색에는 루트나 가상 공간이 필요할 수 있습니다.',
      },
      {
        q: '시간 가속이 왜 불안정한가요?',
        a: '메인 스크립트의 시간 가속은 게임 내 시간 흐름을 변경합니다. 일부 장면에서는 끊기거나 실패할 수 있습니다.',
      },
      {
        q: '스크립트가 작동을 멈췄어요. 어떻게 하나요?',
        a: '게임 업데이트 후 메모리 주소가 바뀔 수 있습니다. 스크립트 업데이트를 기다려 주세요.',
      },
      {
        q: '여러 스크립트를 동시에 쓸 수 있나요?',
        a: '가능하지만 기능이 겹치면 충돌할 수 있습니다. 필요한 것만 불러오세요.',
      },
    ],
  },
  footer: 'sm64coopdx Lua 스크립트 · 개인 프로젝트',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG 스크립트 모음',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: '여러 치트 기능을 하나의 Lua 파일에 담았습니다.',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'AGG 전용 (플로팅 윈도우)',
      features: [
        {
          name: 'Killaura',
          description: '주변 적을 자동으로 공격합니다.',
        },
        {
          name: '비행',
          description: '공중을 자유롭게 날고 벽을 통과합니다.',
        },
        {
          name: '시간 가속',
          description:
            '게임 내 시간을 가속합니다. 불안정 — 일부 장면에서 끊기거나 실패할 수 있습니다.',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component 모니터',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        '플레이어 상태, 좌표, 속도를 실시간으로 모니터링합니다. 강력한 HUD 포함.',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: '마리오 상태 표시',
          description: '마리오의 위치, 속도, 방향, 동작을 실시간으로 표시합니다.',
        },
        {
          name: '보스 모니터',
          description: '보스의 HP를 표시합니다.',
        },
      ],
    },
    {
      id: 'orig',
      name: '대화 상자형 치트',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description: 'AGG와 GG 모두 호환되는 원본 대화 상자형 치트.',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: '기타 치트 모음',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        '스크립트가 아니라 GG에 직접 가져오는 메모리 베이스 주소 데이터입니다. 원하는 대로 수정하세요.',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (메인 Lua 개발자)',
      bio: 'sm64coopdx 플레이어. 중국에서 coopnet에서 밴된 첫 번째 사람.',
      avatar: '/coopdx-cheats-web/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (보조 / Derect Client 개발자)',
      bio: 'DogBro보다 차분함. 초기 스크립트 프레임워크를 구축.',
      avatar: '/coopdx-cheats-web/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};