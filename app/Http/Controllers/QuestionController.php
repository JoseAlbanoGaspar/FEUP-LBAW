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


    public function getAskForm()
    {

        if (!Auth::check()) {
            return redirect()->route('login');
        }
        $this->authorize('askQuestion', Question::class);
        return view('pages.askForm');
    }

    public function postQuestion(Request $request)
    {
        $data = $request->all();
        Post::create([
            'id_author' => $data['id_author'],
            'date' => Carbon::now()->format('Y'),
            'text_body' => $data['text_body']
        ]);

        $new_id = DB::table('post')->latest('id_post')->first()->id_post;

        Question::create([
            'id_question' => $new_id,
            'title' => $data['title']
        ]);

        $question = Question::find($new_id);

        for ($i=1; $i < 5; $i++) {
            if($data['tag'.$i] != NULL) {
                $tag = Tag::where('name',$data['tag'.$i])->first();
                if($tag == NULL) Tag::create(['name' => $data['tag'.$i]]);
                $question->tags[$i-1] = $tag;
            }
        }
        $question->save();

        return redirect()->route('question',['id_question' => $new_id]);
    }
}

