//var users=users||{};
//(function(){
//    $(document).ready(function(){
//       users.get_all();
//    })
//})()
//users.get_all=function(){
//    $.get("/users-all","",function(data){
//        data.isoFunction=function(){
//            var date=new Date(this.created_at);
//            return date.getFullYear()+"."+date.getMonth()+".    "+date.getDate();
//        }
//        var html=Mustache.render("{{#users}}<tr>" +
//            "<td></td>" +
//            "<td>{{name}}</td>" +
//            "<td>{{email}}</td>" +
//            "<td>{{isoFunction}}</td>" +
//            "<td></td>" +
//            "</tr>{{/users}}",data);
//        $("#all-users").append(html);
//    })
//}