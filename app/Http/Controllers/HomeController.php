<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use App\Models\Post;
use App\Models\Question;
use App\Models\Answer;

class HomeController extends Controller
{
    public function home()
    {
        if(Auth::check()){
            return redirect()->route('personalFeed');
        }
        else{
            return redirect()->route('home');
        }
    }
}

