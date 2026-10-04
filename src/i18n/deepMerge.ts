// src/i18n/deepMerge.ts
export type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends (infer U)[]
    ? DeepPartial<U>[]
    : T[P] extends object
      ? DeepPartial<T[P]>
      : T[P];
};

function isPlainObject(v: unknown): v is Record<string, unknown> {
  return typeof v === 'object' && v !== null && !Array.isArray(v);
}

/**
 * 数组合并：如果两个数组的元素都有 id 字段，按 id 匹配合并。
 * 否则整个数组替换。
 */
function mergeArrays(base: unknown[], override: unknown[]): unknown[] {
  const baseHasIds = base.every((x) => isPlainObject(x) && 'id' in x);
  const overrideHasIds = override.every((x) => isPlainObject(x) && 'id' in x);

  if (baseHasIds && overrideHasIds) {
    const out = base.map((b) => {
      const bId = (b as { id: string }).id;
      const o = override.find((x) => (x as { id: string }).id === bId);
      return o ? deepMerge(b, o as never) : b;
    });
    for (const o of override) {
      const oId = (o as { id: string }).id;
      if (!base.some((b) => (b as { id: string }).id === oId)) {
        out.push(o);
      }
    }
    return out;
  }
  return override;
}

export function deepMerge<T>(base: T, override: DeepPartial<T> | undefined): T {
  if (override === undefined || override === null) return base;

  if (Array.isArray(base) && Array.isArray(override)) {
    return mergeArrays(base, override) as unknown as T;
  }

  if (!isPlainObject(base) || !isPlainObject(override)) {
    return override as T;
  }

  const out: Record<string, unknown> = { ...base };
  for (const key of Object.keys(override)) {
    const b = (base as Record<string, unknown>)[key];
    const o = (override as Record<string, unknown>)[key];
    if (isPlainObject(b) && isPlainObject(o)) {
      out[key] = deepMerge(b, o as never);
    } else if (Array.isArray(b) && Array.isArray(o)) {
      out[key] = mergeArrays(b, o);
    } else {
      out[key] = o;
    }
  }
  return out as T;
}