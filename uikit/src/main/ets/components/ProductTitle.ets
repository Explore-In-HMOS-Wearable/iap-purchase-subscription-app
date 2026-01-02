@Component
export struct ProductTitle {
  title!: string

  build() {
    Text(this.title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 20, bottom: 20 })
      .textAlign(TextAlign.Center)
  }
}
