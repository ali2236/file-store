import 'dart:async';
import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/persistance/json_file_store.dart';
import 'package:file_store/src/presentation/card_student.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shelf/shelf.dart';
import 'page_html.dart';

FutureOr<Response> indexPage(Request request) async {
  var studentStore = KiwiContainer().resolve<JsonFileStore<Student>>();
  var students = studentStore.elements;
  return render(
    html: htmlPage(
      title: 'FileStore by Ali.gh',
      body: '''<div class="container">
    <div class="row my-2">
        <div class="col">
            <div class="card p-2">
                <div class="card-title text-center">
                    <h3>New Student</h3>
                </div>
                <div class="card-body">
                    <form method="post" action="/students">
                        <div class="form-group">
                            <label for="std-id">Student id</label>
                            <input id="std-id" class="form-control" name="id" type="number" placeholder="Student id">
                        </div>
                        <div class="form-group">
                            <label for="std-fn">Student First Name</label>
                            <input id="std-fn" class="form-control" name="firstName" type="text" placeholder="First Name">
                        </div>
                        <div class="form-group">
                            <label for="std-ln">Student Last Name</label>
                            <input id="std-ln" type="text" class="form-control" name="lastName" placeholder="Last Name">
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
          <div class="card">
            <div class="card-title"><h3 class="m-4">All Students</h3></div>
            <div class="card-body">
                ${students.map(studentCard).join('\n')}
            </div>
        </div>
        </div>
    </div>
</div>
      ''',
    ),
  );
}


