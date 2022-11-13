<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Post;
use App\Models\Question;
use App\Models\Answer;

class PostController extends Controller
{
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id_user)
    {      

      return view('posts.post', ['post' => $post]);
    }

    public function showQuestions($id_user){
        $questions = DB::table('post')
                    ->join('question','post.id_post','=','question.id_question')
                    ->select('post.text_body','post.date','question.title')
                    ->where('post.id_author',$id_user)->get();
        
        return view('posts.question',['questions' => $questions]);
    }
}

