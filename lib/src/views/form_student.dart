import 'package:file_store/src/models/student.dart';

String studentForm({Student student, String action = '/students', String method = 'post'}){
  return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>New Student</h3>
    </div>
    <div class="card-body">
        <form method="$method" action="$action">
            <div class="form-group">
                <label for="std-id">Student id</label>
                <input id="std-id" class="form-control" name="id" type="number" placeholder="Student id" ${student?.id!=null ? 'value="${student?.id}' : ''}">
            </div>
            <div class="form-group">
                <label for="std-fn">Student First Name</label>
                <input id="std-fn" class="form-control" name="firstName" type="text" placeholder="First Name" value="${student?.firstName ?? ''}">
            </div>
            <div class="form-group">
                <label for="std-ln">Student Last Name</label>
                <input id="std-ln" type="text" class="form-control" name="lastName" placeholder="Last Name" value="${student?.lastName ?? ''}">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
}