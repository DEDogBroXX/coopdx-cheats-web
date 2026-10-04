// src/data/types.ts
export interface Feature {
  name: string;
  description: string;
  screenshot?: string;
}

export interface Script {
  id: string;
  name: string;
  version: string;
  lastUpdate: string;
  description: string;
  fileName: string;
  downloadUrl: string;
  requirement?: string;
  note?: string;
  features?: Feature[];
}

export interface AuthorLink {
  label: string;
  url: string;
}

export interface Author {
  name: string;
  role?: string;
  bio: string;
  avatar?: string;
  links?: AuthorLink[];
}

export interface FAQItem {
  q: string;
  a: string;
}

export interface Step {
  title: string;
  items: string[];
}

export interface Screenshot {
  src: string;
  title: string;
  description?: string;
}

export interface Content {
  meta: {
    title: string;
    description: string;
  };
  hero: {
    title: string;
    subtitle: string;
  };
  nav: {
    howto: string;
    author: string;
    faq: string;
    screenshots: string;
    langSwitch: string;
  };
  download: {
    btn: string;
    version: string;
    updated: string;
  };
  howto: {
    heading: string;
    steps: Step[];
    notice: string;
  };
  author: {
    heading: string;
  };
  faq: {
    heading: string;
    items: FAQItem[];
  };
  gallery: {
    heading: string;
    subtitle: string;
    empty: string;
    backHome: string;
    screenshots: Screenshot[];
  };
  footer: string;
  scripts: Script[];
  authors: Author[];
}