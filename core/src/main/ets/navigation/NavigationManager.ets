@ObservedV2
export class NavigationManager {
  static _instance: NavigationManager;
  @Trace pageInfos: NavPathStack = new NavPathStack()
  @Trace pageList: PageModel[] = [];

  static getInstance() {
    if (!NavigationManager._instance) {
      NavigationManager._instance = new NavigationManager();
    }

    return NavigationManager._instance;
  }
}

export class PageModel {
  page: () => void;
  pageRoute: string = '';

  constructor(page: () => void, pageRoute: string) {
    this.page = page;
    this.pageRoute = pageRoute;
  }
}
