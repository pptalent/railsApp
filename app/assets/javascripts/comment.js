(function(){
    $(document).ready(function(){
        $("body")
            .on("click",".comment",function(){
                var id=$(this).attr("id");
                $.get("/comments/list",{id:id},function(data){

                })
            })
    })
})()