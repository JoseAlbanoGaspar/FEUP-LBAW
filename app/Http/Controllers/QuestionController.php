<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

use App\Models\Post;
use App\Models\Question;
use App\Models\Answer;

class QuestionController extends PostController
{
    /**
     * Shows the question for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
        $post = Post::find($id);
        $answers = $post->question->answers;

        return view('pages.question', ['post' => $post, 'answers' => $answers]);
    }

    public function postAnswer(Request $request, $id)
    {
        $question = Post::find($id);

        //adicionar resposta


    }

    public function getAskForm()
    {
        return view('pages.askForm');
    }

    public function postQuestion(Request $request)
    {
        //adicionar pergunta


    }
}

