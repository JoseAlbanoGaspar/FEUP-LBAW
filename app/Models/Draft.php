<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Draft
 *
 * @property int $id_draft
 * @property Carbon $date
 * @property int $id_author
 * @property string|null $title
 * @property string|null $text_body
 *
 * @property User $user
 *
 * @package App\Models
 */
class Draft extends Model
{
	protected $table = 'draft';
    protected $primaryKey = 'id_draft';
	public $timestamps = false;

	protected $casts = [
		'id_author' => 'int'
	];

	protected $dates = [
		'date'
	];

	protected $fillable = [
		'date',
		'id_author',
		'title',
		'text_body'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_author')
//					->where('user.id_user', '=', 'draft.id_author')
					->where('users.id_user', '=', 'draft.id_author');
	}
}
