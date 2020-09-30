import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/views/presenters/presenter.dart';

class MemberPresenter extends StoreObjectPresenter<Member> {
  MemberPresenter() : super(members, 'Member');

  @override
  String buildForm(FormType type, {Member model}) {
    var isEdit = type == FormType.edit;
    return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>${isEdit ? 'Edit ${modelName}' : 'Add a new ${modelName}'}</h3>
    </div>
    <div class="card-body">
        <form method="post" action="${isEdit ? '/$baseUrl/${model.storeId}' : '/$baseUrl'}">
            <div class="form-group">
                <label for="std-fn">${modelName} First Name</label>
                <input id="std-fn" class="form-control" name="firstName" type="text" placeholder="First Name" value="${model?.firstName ?? ''}">
            </div>
            <div class="form-group">
                <label for="std-ln">${modelName} Last Name</label>
                <input id="std-ln" type="text" class="form-control" name="lastName" placeholder="Last Name" value="${model?.lastName ?? ''}">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
  }

  @override
  String buildItem(Member model) {
    return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${model.firstName} ${model.lastName}</h4>
    <p>First Name: ${model.firstName}</p>
    <p>Last Name: ${model.lastName}</p>
    <div>
    <a class="btn btn-secondary" type="button" href="/$baseUrl/edit/${model.storeId}">Edit</a>
    <a class="btn btn-danger" type="button" href="/$baseUrl/delete/${model.storeId}">Delete</a>
    </div>
  </div>
  ''';
  }

  @override
  String buildList(List<Member> models) {
    return '''
  <div class="card">
    <div class="card-title"><h3 class="m-4">All Members</h3></div>
    <div class="card-body">
        ${searchBar('/search/$baseUrl')}
        ${models.map(buildItem).join('\n')}
     </div>
</div>
  ''';
  }

}