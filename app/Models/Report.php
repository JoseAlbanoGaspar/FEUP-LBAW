<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Report
 *
 * @property int $id_report
 * @property int $id_user
 * @property int $id_post
 * @property string $reason
 * @property Carbon $date
 *
 * @property User $user
 * @property Post $post
 *
 * @package App\Models
 */
class Report extends Model
{
	protected $table = 'report';
    protected $primaryKey = 'id_report';
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
		'reason',
		'date'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user')
					->where('user.id_user', '=', 'report.id_user')
					->where('user.id_user', '=', 'report.id_user');
	}

	public function post()
	{
		return $this->belongsTo(Post::class, 'id_post')
					->where('post.id_post', '=', 'report.id_post')
					->where('post.id_post', '=', 'report.id_post');
	}
}
