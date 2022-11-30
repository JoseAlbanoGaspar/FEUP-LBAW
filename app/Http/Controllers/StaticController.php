<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;


class StaticController extends Controller
{
    public function showAbout()
    {
      return view('pages.about');
    }

    public function showRules()
    {
      return view('pages.Rules');
    }
}