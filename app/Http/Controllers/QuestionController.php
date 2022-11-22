<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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
     * @param int $id
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
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

    /**
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function getAskForm(Request $request)
    {

        if (!Auth::check()) {
            return redirect()->route('login');
        }
        $this->authorize('askQuestion');
        return view('pages.askForm');
    }

    public function postQuestion(Request $request)
    {
        //adicionar pergunta


    }
}

