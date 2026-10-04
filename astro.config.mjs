import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://toad114514.github.io',
  base: '/coopdx-cheats-web',
  i18n: {
    defaultLocale: 'zh',
    locales: ['zh', 'en', 'ja', 'ko', 'ru', 'es', 'pt', 'de', 'fr', 'hi'],
    routing: {
      prefixDefaultLocale: false,
    },
  },
});