// src/data/hi.ts
import type { Content } from './types';

export const content: Partial<Content> = {
  meta: {
    title: 'sm64coopdx Lua स्क्रिप्ट',
    description:
      'sm64coopdx के लिए AGG / GG पर Lua स्क्रिप्ट। चीट, मॉनिटरिंग और टूल्स।',
  },
  hero: {
    title: 'sm64coopdx Lua स्क्रिप्ट',
    subtitle:
      'AGG / GG के लिए Lua स्क्रिप्ट। फ्लोटिंग विंडो मेनू, एक टैप में टॉगल।',
  },
  nav: {
    howto: 'कैसे उपयोग करें',
    author: 'लेखक',
    faq: 'सामान्य प्रश्न',
    langSwitch: 'हिन्दी',
  },
  download: {
    btn: '.lua डाउनलोड करें',
    version: 'v',
    updated: 'अपडेट किया गया',
  },
  howto: {
    heading: 'कैसे उपयोग करें',
    steps: [
      {
        title: 'इंस्टॉलेशन',
        items: [
          'ऊपर दिए गए सेक्शन से <code>.lua</code> फ़ाइल डाउनलोड करें।',
          'फ़ाइल को अपने फ़ोन में कहीं भी रखें (पाथ याद रखें)।',
          '<strong>AGG या GG</strong> खोलें और फ्लोटिंग विंडो की अनुमति दें।',
        ],
      },
      {
        title: 'स्क्रिप्ट लोड करें',
        items: [
          'पहले sm64coopdx शुरू करें और गेम में प्रवेश करें।',
          'फ्लोटिंग विंडो आइकन पर टैप करके मेनू खोलें।',
          '«स्क्रिप्ट चलाएँ» या «Lua लोड करें» चुनें और डाउनलोड की गई <code>.lua</code> फ़ाइल खोजें।',
          'निष्पादन की पुष्टि करें। स्क्रिप्ट मेनू फ्लोटिंग विंडो में दिखाई देगा।',
        ],
      },
      {
        title: 'फ़ीचर का उपयोग करें',
        items: [
          'किसी फ़ीचर के नाम पर टैप करके उसे चालू / बंद करें।',
          'कुछ फ़ीचर में संख्यात्मक विकल्प होते हैं (जैसे उड़ान की गति) — संकेत अनुसार मान दर्ज करें।',
          'गेम से बाहर निकलने से पहले सभी फ़ीचर बंद कर दें, ताकि अगली बार कोई समस्या न हो।',
        ],
      },
    ],
    notice:
      'ध्यान दें: मुख्य स्क्रिप्ट <strong>केवल AGG (फ्लोटिंग विंडो)</strong> के लिए है। यह GameGuardian या अन्य टूल्स के साथ काम नहीं करती।',
  },
  author: { heading: 'लेखक' },
  faq: {
    heading: 'सामान्य प्रश्न',
    items: [
      {
        q: 'क्या मुझे Root चाहिए?',
        a: 'कुछ डिवाइस बिना Root के काम करते हैं, लेकिन मेमोरी स्कैन के लिए Root या वर्चुअल स्पेस की ज़रूरत हो सकती है।',
      },
      {
        q: 'समय की गति अस्थिर क्यों है?',
        a: 'मुख्य स्क्रिप्ट की समय गति खेल के समय-प्रवाह को बदलती है। कुछ दृश्यों में रुकावट या विफलता हो सकती है।',
      },
      {
        q: 'स्क्रिप्ट काम करना बंद हो गई। अब क्या?',
        a: 'गेम अपडेट के बाद मेमोरी एड्रेस बदल सकते हैं। स्क्रिप्ट अपडेट का इंतज़ार करें।',
      },
      {
        q: 'क्या मैं एक साथ कई स्क्रिप्ट इस्तेमाल कर सकता हूँ?',
        a: 'हाँ, लेकिन ओवरलैप होने वाले फ़ीचर आपस में टकरा सकते हैं। ज़रूरत के अनुसार ही लोड करें।',
      },
    ],
  },
  footer: 'sm64coopdx Lua स्क्रिप्ट · व्यक्तिगत प्रोजेक्ट',
  scripts: [
    {
      id: 'main',
      name: 'sm64coopdx AGG संग्रह',
      version: '1.5.1',
      lastUpdate: '2026-10-04',
      description: 'एक ही Lua फ़ाइल में कई चीट फ़ीचर।',
      fileName: 'sm64-agg-v1.5.1.lua',
      downloadUrl: '/sm64-agg-v1.5.1.lua',
      requirement: 'केवल AGG (फ्लोटिंग विंडो)',
      features: [
        {
          name: 'Killaura',
          description: 'आस-पास के दुश्मनों पर अपने आप हमला करता है।',
        },
        {
          name: 'उड़ान',
          description: 'हवा में स्वतंत्र रूप से उड़ें, दीवारों के आर-पार जाएँ।',
        },
        {
          name: 'समय की गति',
          description:
            'खेल के समय को तेज़ करता है। अस्थिर — कुछ दृश्यों में रुकावट या विफलता हो सकती है।',
        },
      ],
    },
    {
      id: 'monitor',
      name: 'AGG Component मॉनिटर',
      version: '2.0',
      lastUpdate: '2026-10-04',
      description:
        'खिलाड़ी की स्थिति, निर्देशांक और गति की रियल-टाइम मॉनिटरिंग। शक्तिशाली HUD के साथ।',
      fileName: 'agg-monitor-v2.0.lua',
      downloadUrl: '/agg-monitor-v2.0.lua',
      requirement: 'AGG Lua Component',
      features: [
        {
          name: 'मारियो स्थिति प्रदर्शन',
          description:
            'मारियो की स्थिति, गति, दिशा और क्रिया रियल-टाइम में दिखाता है।',
        },
        {
          name: 'बॉस मॉनिटर',
          description: 'बॉस की HP दिखाता है।',
        },
      ],
    },
    {
      id: 'orig',
      name: 'डायलॉग शैली चीट',
      version: 'v10.0',
      lastUpdate: '2026-10-04',
      description:
        'मूल डायलॉग शैली चीट, AGG और GG दोनों के साथ संगत।',
      fileName: 'sm64-agg-dialog-v10.lua',
      downloadUrl: '/sm64-agg-dialog-v10.lua',
      requirement: 'AGG / GG',
    },
    {
      id: 'misc',
      name: 'विविध चीट संग्रह',
      version: 'V7',
      lastUpdate: '2026-10-04',
      description:
        'स्क्रिप्ट नहीं — GG में सीधे आयात किए जाने वाले मेमोरी बेस एड्रेस डेटा। कुछ भी बदलें।',
      fileName: 'sm64-misc-v7.lua',
      downloadUrl: '/sm64-misc-v7.lua',
      requirement: 'GG',
    },
  ],
  authors: [
    {
      name: '狗哥又玩又爱玩',
      role: ' (मुख्य Lua डेवलपर)',
      bio: 'sm64coopdx खिलाड़ी। चीन में coopnet से प्रतिबंधित पहला व्यक्ति।',
      avatar: '/dogbro.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'GitHub', url: '#' },
      ],
    },
    {
      name: 'toadXtech64',
      role: ' (सहायक / Derect Client डेवलपर)',
      bio: 'DogBro से ज़्यादा संयमित। शुरुआती स्क्रिप्ट फ़्रेमवर्क बनाया।',
      avatar: '/toad.jpg',
      links: [
        { label: 'Bilibili', url: '#' },
        { label: 'Discord', url: '#' },
      ],
    },
  ],
};