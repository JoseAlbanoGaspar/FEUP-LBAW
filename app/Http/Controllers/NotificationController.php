<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use DateTime;
use Illuminate\Support\Facades\Log;
use App\Models\Notification;


class NotificationController extends Controller
{
    public function show(){
        $notifications = auth()->user()->notifications()->orderBy('dismissed', 'asc')->orderBy('date','desc')->paginate(10);
        return view('pages.notifications',compact('notifications'));
    }
}
