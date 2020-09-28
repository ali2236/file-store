String searchBar(String action) {
  return '''
<form class="form-inline my-2 my-lg-0" action="$action" method="post">
    <input class="form-control mr-sm-2" name="search" type="search" placeholder="Search" aria-label="Search">
    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
</form>
  ''';
}
