<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Edit
 *
 * @property int $id_edit
 * @property int $id_user
 * @property int $id_post
 * @property string $old_text
 * @property Carbon $date
 *
 * @property User $user
 * @property Post $post
 *
 * @package App\Models
 */
class Edit extends Model
{
	protected $table = 'edit';
    protected $primaryKey = 'id_edit';
	public $timestamps = false;

	protected $casts = [
		'id_user' => 'int',
		'id_post' => 'int'
	];

	protected $dates = [
		'date'
	];

	protected $fillable = [
		'id_user',
		'id_post',
		'old_text',
		'date'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user');
	}

	public function post()
	{
		return $this->belongsTo(Post::class, 'id_post');
	}
}
