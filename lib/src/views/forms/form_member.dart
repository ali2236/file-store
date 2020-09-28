import 'package:file_store/src/models/member.dart';

String memberForm(
    {Member member,
    String action = '/$members',
    String method = 'post',
    String title = 'New Member'}) {
  return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>$title</h3>
    </div>
    <div class="card-body">
        <form method="$method" action="$action">
            <div class="form-group">
                <label for="std-fn">Member First Name</label>
                <input id="std-fn" class="form-control" name="firstName" type="text" placeholder="First Name" value="${member?.firstName ?? ''}">
            </div>
            <div class="form-group">
                <label for="std-ln">Member Last Name</label>
                <input id="std-ln" type="text" class="form-control" name="lastName" placeholder="Last Name" value="${member?.lastName ?? ''}">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
}
