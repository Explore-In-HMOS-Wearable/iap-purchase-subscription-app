import { iap } from '@kit.IAPKit';

export interface ProductMeta {
  id: string
  displayName: string
  image?: Resource
}

export interface ProductDefinition {
  id: string;
  type: iap.ProductType;

  title: string;
  icon: Resource;

  description?: string;
  order?: number;

  price?: number;
  currency?: string;
  purchaseTime?: string;
}


export class ProductManager {

  static consumables: ProductDefinition[] = [
    {
      id: 'consumable1',
      type: iap.ProductType.CONSUMABLE,
      title: '10 Credits',
      description: 'consumable test product',
      icon: $r('app.media.consumable'),
      order: 1
    },
    {
      id: 'consumable2',
      type: iap.ProductType.CONSUMABLE,
      title: '50 Credits',
      description: 'consumable test product',
      icon: $r('app.media.consumable'),
      order: 2
    },
    {
      id: 'consumable3',
      type: iap.ProductType.CONSUMABLE,
      title: '75 Credits',
      description: 'consumable test product',
      icon: $r('app.media.consumable'),
      order: 3
    },
    {
      id: 'consumable4',
      type: iap.ProductType.CONSUMABLE,
      title: '100 Credits',
      description: 'consumable test product',
      icon: $r('app.media.consumable'),
      order: 4
    }
  ]

  static nonConsumables: ProductDefinition[] = [
    {
      id: 'nonConsumable1',
      type: iap.ProductType.NONCONSUMABLE,
      title: 'Remove Ads',
      description: 'non consumable test product',
      icon: $r('app.media.removeads'),
      order: 1
    },
    {
      id: 'nonConsumable2',
      type: iap.ProductType.NONCONSUMABLE,
      title: 'Pro Features',
      description: 'non consumable test product',
      icon: $r('app.media.pro_features'),
      order: 1
    },
    {
      id: 'nonConsumable3',
      type: iap.ProductType.NONCONSUMABLE,
      title: 'Premium Pack',
      description: 'non consumable test product',
      icon: $r('app.media.pro_features'),
      order: 1
    }
  ]

  static autoRenewables: ProductDefinition[] = [
    {
      id: 'autoRenewable1',
      type: iap.ProductType.AUTORENEWABLE,
      title: 'Pro Weekly',
      description: 'auto Renewables test product',
      icon: $r('app.media.pro'),
      order: 1
    },
    {
      id: 'autoRenewable2',
      type: iap.ProductType.AUTORENEWABLE,
      title: 'Pro Monthly',
      description: 'auto Renewables test product',
      icon: $r('app.media.pro'),
      order: 2
    },
    {
      id: 'autoRenewable3',
      type: iap.ProductType.AUTORENEWABLE,
      title: 'Pro Yearly',
      description: 'auto Renewables test product',
      icon: $r('app.media.pro'),
      order: 3
    },
    {
      id: 'autoRenewable4',
      type: iap.ProductType.AUTORENEWABLE,
      title: 'Pro Lifetime',
      description: 'auto Renewables test product',
      icon: $r('app.media.pro'),
      order: 4
    }
  ]

  static nonRenewings: ProductDefinition[] = [
    {
      id: 'NonRenewing1',
      type: iap.ProductType.NONRENEWABLE,
      title: '1-Month Pass',
      description: 'Non Renewing test product',
      icon: $r('app.media.pass'),
      order: 1
    },
    {
      id: 'NonRenewing2',
      type: iap.ProductType.NONRENEWABLE,
      title: '3-Month Pass',
      description: 'Non Renewing test product',
      icon: $r('app.media.pass'),
      order: 2
    },
    {
      id: 'NonRenewing3',
      type: iap.ProductType.NONRENEWABLE,
      title: '6-Month Pass',
      description: 'Non Renewing test product',
      icon: $r('app.media.pass'),
      order: 3
    },
    {
      id: 'NonRenewing4',
      type: iap.ProductType.NONRENEWABLE,
      title: '1-Year Pass',
      description: 'Non Renewing test product',
      icon: $r('app.media.pass'),
      order: 4
    }
  ]

  static all(): ProductDefinition[] {
    return [
      ...ProductManager.consumables,
      ...ProductManager.nonConsumables,
      ...ProductManager.autoRenewables,
      ...ProductManager.nonRenewings
    ]
  }

  static idsOf(list: ProductDefinition[]): string[] {
    return list.map(p => p.id)
  }

  static findById(id: string): ProductDefinition | undefined {
    return ProductManager.all().find(p => p.id === id)
  }

  static findMeta(id: string): ProductMeta | undefined {
    const def = ProductManager.findById(id)
    if (!def) {
      return undefined
    }

    return {
      id: def.id,
      displayName: def.title,
      image: def.icon
    }
  }

  static formatPurchaseDate(timestamp: number): string {
    const date = new Date(timestamp);

    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
  }
}



