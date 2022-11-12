<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class FollowsTag
 *
 * @property int $id_user
 * @property int $id_tag
 *
 * @property User $user
 * @property Tag $tag
 *
 * @package App\Models
 */
class FollowsTag extends Model
{
	protected $table = 'follows_tag';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_user' => 'int',
		'id_tag' => 'int'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user')
//					->where('user.id_user', '=', 'follows_tag.id_user')
					->where('user.id_user', '=', 'follows_tag.id_user');
	}

	public function tag()
	{
		return $this->belongsTo(Tag::class, 'id_tag')
//					->where('tag.id_tag', '=', 'follows_tag.id_tag')
					->where('tag.id_tag', '=', 'follows_tag.id_tag');
	}
}
