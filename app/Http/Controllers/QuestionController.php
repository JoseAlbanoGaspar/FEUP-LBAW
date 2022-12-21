<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

use App\Models\Post;
use App\Models\Question;
use App\Models\Answer;
use App\Models\Tag;
use App\Models\QuestionTag;

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
//        $this->authorize('postAnswer', [Answer::Class, Question::find($id)]);

        if(!Auth::check()){
            return redirect()->route('login');
        }
        $post = Post::find($id);
        $id_user = Auth::id();

        if($id_user == $post->id_author){
            return redirect()->route('question', ['id_question' => $id]);
        }

        $data = $request->all();
        Post::create([
            'id_author' => $data['id_author'],
            'date' => Carbon::now()->format('Y'),
            'text_body' => $data['text_body']
        ]);

        $new_id = DB::table('post')->latest('id_post')->first()->id_post;

        Answer::create([
            'id_answer' => $new_id,
            'id_question' => $id,
            'is_solution' => '0',
            'score' => 0
        ]);

        return redirect()->route('question',['id_question' => $id]);

    }


    public function getAskForm(Request $request)
    {

        if (!Auth::check()) {
            return redirect()->route('login');
        }

        $title = $request->input('title');
        $text_body = $request->input('text_body');

        $tags = Tag::all();

        $this->authorize('askQuestion', Question::class);
        return view('pages.askForm', ['tags' => $tags,'title' => $title, 'text_body' => $text_body]);
    }

    public function postQuestion(Request $request)
    {
        $data = $request->all();

        Post::create([
            'id_author' => $data['id_author'],
            'date' => Carbon::now(),
            'text_body' => $data['text_body']
        ]);

        $new_id = DB::table('post')->latest('id_post')->first()->id_post;

        Question::create([
            'id_question' => $new_id,
            'title' => $data['title']
        ]);

        for ($i=1; $i < 5; $i++) {
            if($data['tag'.$i] != "-1") {
                QuestionTag::create([
                    'id_tag' => $data['tag'.$i],
                    'id_question' => $new_id
                ]);
            }
        }

        return redirect()->route('question',['id_question' => $new_id]);
    }
}

