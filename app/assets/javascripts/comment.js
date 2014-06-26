(function(){
    $(document).ready(function(){
        $("body")
            .on("click",".comment",function(){
                var id=$(this).attr("id");
                var $this=$(this);
                if($this.attr("state")!=="open"){
                    $this.parents("li").next().slideDown();
                    $this.attr("state","open");
                    $.get("/comments/list",{id:id},function(data){
                        $this.parents("li").next().html(data);
                    })
                }
                else{
                    $this.attr("state","close");
                    $this.parents("li").next().slideUp();
                }
            })
            .on("click",".comment-submit-button",function(){
                var $this=$(this),
                    id=$this.attr("id"),
                    $textarea=$this.prevAll('textarea'),
                    content= $.trim($textarea.val()),
                    $form=$(this).parents(".form"),
                    $comment_count=$(this).parents(".comment-list").prev().find(".comment-count");
                $.post("/comments",{
                     micropost_id:id,
                     content:content
                },function(data){
                     if(data.result){
                         var result=data.content;
                         var html='<li>'+
                             '<p><a class="comment-user" href="/users/'+result.user_id+'">'+result.user_name+' :</a>'+result.content+'</p>'+
                             '<span>'+result.created_at+'</span>'+
                             '<i class="glyphicon glyphicon-remove trash-icon" id="'+result.comment_id+'"></i>'+
                             '</li>'
                         $form.next("ul").prepend(html);
                         $textarea.val("");
                         var count= parseInt( $comment_count.text() );
                         $comment_count.text( ++count );
                     }
                    else{
                         var content=data.content;
                         var html='<div class="bs-callout bs-callout-danger"><ul>'
                         for(var key in content){
                             for(var i=0;i<content[key].length;i++){
                                  html+='<li>'+key+' : '+content[key][i]+'</li>'
                             }
                         }
                         html+='</ul></div>'
                         $form.after(html);
                         window.setTimeout(function(){
                             $form.next().remove();
                         },4500)
                     }
                })
            })
            .on("click",".trash-icon",function(){
                var $this=$(this),
                    comment_id=$this.attr("id"),
                    $comment_count=$(this).parents(".comment-list").prev().find(".comment-count");
                if(confirm("Delete this comment ?")){
                    $.ajax({
                        url:"/comments/"+comment_id,
                        type:"DELETE",
                        success:function(data){
                            if(data.result){
                                $this.parents("li").eq(0).remove();
                                var count= parseInt( $comment_count.text() );
                                $comment_count.text( --count );
                            }
                            else{
                                alert("sth wrong happened !");
                            }
                        }
                    })
                }

            })
    })
})()