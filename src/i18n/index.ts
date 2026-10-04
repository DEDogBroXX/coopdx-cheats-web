// src/i18n/index.ts
import { content as zh } from '../data/zh';
import { content as en } from '../data/en';
import { content as ja } from '../data/ja';
import { content as ko } from '../data/ko';
import { content as ru } from '../data/ru';
import { content as es } from '../data/es';
import { content as pt } from '../data/pt';
import { content as de } from '../data/de';
import { content as fr } from '../data/fr';
import { content as hi } from '../data/hi';
import type { Content } from '../data/types';
import { deepMerge } from './deepMerge';

export const languages = {
  zh: { label: '中文', htmlLang: 'zh-CN', content: zh },
  en: { label: 'English', htmlLang: 'en', content: en },
  ja: { label: '日本語', htmlLang: 'ja', content: deepMerge(en, ja) },
  ko: { label: '한국어', htmlLang: 'ko', content: deepMerge(en, ko) },
  ru: { label: 'Русский', htmlLang: 'ru', content: deepMerge(en, ru) },
  es: { label: 'Español', htmlLang: 'es', content: deepMerge(en, es) },
  pt: { label: 'Português', htmlLang: 'pt-BR', content: deepMerge(en, pt) },
  de: { label: 'Deutsch', htmlLang: 'de', content: deepMerge(en, de) },
  fr: { label: 'Français', htmlLang: 'fr', content: deepMerge(en, fr) },
  hi: { label: 'हिन्दी', htmlLang: 'hi', content: deepMerge(en, hi) },
} as const;

export type Lang = keyof typeof languages;

export const defaultLang: Lang = 'zh';

/**
 * 生成语言对应的路径。
 * pathFor('zh') → '/'
 * pathFor('en') → '/en/'
 * pathFor('zh', 'screenshots') → '/screenshots'
 * pathFor('en', 'screenshots') → '/en/screenshots'
 */
export function pathFor(lang: Lang, subpath = ''): string {
  const base = import.meta.env.BASE_URL.replace(/\/$/, '');
  const prefix = lang === defaultLang ? '' : `/${lang}`;
  const clean = subpath.replace(/^\/+|\/+$/g, '');
  if (!clean) return `${base}${prefix}/` || '/';
  return `${base}${prefix}/${clean}`;
}

export function getContent(lang: Lang): Content {
  return languages[lang].content;
}

export function getLangFromUrl(url: URL): Lang {
  const seg = url.pathname.split('/').filter(Boolean)[0];
  if (seg && seg in languages) return seg as Lang;
  return defaultLang;
}