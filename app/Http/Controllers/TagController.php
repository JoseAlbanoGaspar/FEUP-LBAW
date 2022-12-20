<?php
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

use App\Models\Tag;

class TagController extends Controller
{

    /**
     * @param Request $req
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function createTag(Request $req){
        $this->authorize('isAdministrator', User::class);
        Tag::create(['name' => $req->tag]);
        return redirect()->back();
    }

    /**
     * @param Request $req
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function deleteTag(Request $req){
        $this->authorize('isAdministrator', User::class);
        $tag = Tag::find($req->id_tag);
        $tag->delete();
        return redirect()->back();
    }

    /**
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function showAllTags(){
        $tags = Tag::all();
        return view('pages.tags', ['tags' => $tags]);
    }

    /**
     * @param $id
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function showTag($id){
        $tag = Tag::find($id);
        return view('pages.tag', ['tag' => $tag]);

    }
}
