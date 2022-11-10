<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Tag
 *
 * @property int $id_tag
 * @property string $name
 *
 * @property Collection|Question[] $questions
 * @property Collection|FollowTagNotif[] $follow_tag_notifs
 * @property Collection|FollowsTag[] $follows_tags
 *
 * @package App\Models
 */
class Tag extends Model
{
	protected $table = 'tag';
    protected $primaryKey = 'id_tag';
    public $timestamps = false;

	protected $fillable = [
		'name'
	];

	public function questions()
	{
		return $this->belongsToMany(Question::class, 'question_tag', 'id_tag', 'id_question');
	}

	public function follow_tag_notifs()
	{
		return $this->hasMany(FollowTagNotif::class, 'id_tag');
	}

	public function follows_tags()
	{
		return $this->hasMany(FollowsTag::class, 'id_tag');
	}
}
