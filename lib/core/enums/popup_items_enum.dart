enum PopupItemsEnum {
  done(name: "Done"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;
  const PopupItemsEnum({required this.name});
}
