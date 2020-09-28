import 'package:file_store/src/models/member.dart';
import 'file:///C:/Users/Aligator/projects/file_store/lib/src/views/forms/element_search_bar.dart';
import '../items/card_member.dart';

String memberListCard(List<Member> memberList){
  return '''
  <div class="card">
    <div class="card-title"><h3 class="m-4">All Members</h3></div>
    <div class="card-body">
        ${searchBar('/search/$members')}
        ${memberList.map(memberCard).join('\n')}
     </div>
</div>
  ''';
}