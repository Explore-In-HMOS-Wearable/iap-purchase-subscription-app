import { common } from '@kit.AbilityKit';

export class AbilityContextProvider {
  private static ctx?: common.UIAbilityContext;

  static set(context: common.UIAbilityContext): void {
    AbilityContextProvider.ctx = context;
  }

  static get(): common.UIAbilityContext {
    if (!AbilityContextProvider.ctx) {
      throw new Error('UIAbilityContext not ready');
    }
    return AbilityContextProvider.ctx;
  }

  static clear(): void {
    AbilityContextProvider.ctx = undefined;
  }
}