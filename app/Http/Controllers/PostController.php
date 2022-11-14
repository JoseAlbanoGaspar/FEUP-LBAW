<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{

    //function that receives a string query and returns a list of posts that match that query
    public function search(Request $request){
        $query = $request->query('query');
        $filters = $request->query('filters');

        if($filters === null){
            $filters = 'all';
        }

        if($filters == 'questions'){
            $posts =  Post::query()
                ->whereRaw('id_post IN (SELECT id_question FROM question)')
                ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }
        else if($filters == 'answers'){
            $posts =  Post::query()
                ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }
        else{
            $posts =  Post::query()
                ->whereRaw('(id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }

        return view('pages.search', ['posts' => $posts]);

    }
}
