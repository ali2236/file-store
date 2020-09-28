import 'package:file_store/src/models/member.dart';

String memberCard(Member member) {
  return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${member.firstName} ${member.lastName}</h4>
    <p>First Name: ${member.firstName}</p>
    <p>Last Name: ${member.lastName}</p>
    <div>
    <a class="btn btn-secondary" type="button" href="/$members/edit/${member.storeId}">Edit</a>
    <a class="btn btn-danger" type="button" href="/$members/delete/${member.storeId}">Delete</a>
    </div>
  </div>
  ''';
}
