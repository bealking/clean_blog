	class CommentsList extends React.Component {
		constructor(props) {
			super(props);
			this.state = {
				items: []
			};

			this.handleClick = this.handleClick.bind(this);
			this.handleDig = this.handleDig.bind(this);
      this.loadData = this.loadData.bind(this);
		}

    renderListItem(items) {
      return items.map((item, index) =>
				<blockquote key={index}>
					<p>{item.body}</p>
					<footer>
            <span>{item.created_at} by {item.user_email}</span>
            <div className="pull-right">
              {(this.props.userId && !item.is_followed) &&
                <a href="javascript:;" data-id={item.id} onClick={this.handleDig}>赞</a>
              }
            </div>
          </footer>
				</blockquote>
      )
    }

    handleDig(event) {
      event.preventDefault();
      let id = event.target.getAttribute('data-id');

      fetch("/comments/"+id+"/dig.json", {
          method: 'PUT',
          headers: new Headers({
            'Content-Type': 'application/json'
          })
        })
				.then(res => res.json())
				.then(
					(result) => {
            if(result.message=='OK') {
              this.loadData();
            }
					}
				)
    }

    componentDidMount() {
      this.loadData();
    }

    loadData() {
      fetch("/comments.json?commentable_type="+this.props.objectType+"&commentable_id="+this.props.objectId, {
        })
				.then(res => res.json())
				.then(
					(result) => {
            this.setState({
              items: this.renderListItem(result)
            });
					}
				)
    }

		handleClick(event) {
      event.preventDefault();

      fetch("/comments.json", {
          method: 'POST',
          body: JSON.stringify({commentable_type: this.props.objectType, commentable_id: this.props.objectId, body: this.refs.commentBody.value}),
          headers: new Headers({
            'Content-Type': 'application/json'
          })
        })
				.then(res => res.json())
				.then(
					(result) => {
            if(result.id) {
              this.loadData();
            }
					}
				)
		}

		render() {
		  let commentFormHtml;

      if(this.props.userId) {
         commentFormHtml = <form className="form-comment">
          <textarea className="form-control" id="commentBody" rows="3" ref="commentBody"></textarea>
          <button className="btn btn-lg btn-default btn-block" type="submit" onClick={this.handleClick}>提交</button>
          </form>
      } else {
        commentFormHtml = <div className="form-actions">
          <a className="btn btn-primary" href="/users/not_authenticated">登陆</a> 后方可回复, 如果您还没有账号请先 <a className="btn btn-danger" href="/users/new">注册</a>
          </div>
      }
			return (
			  <div>
          {this.state.items}
          <h3>添加评论</h3>
          {commentFormHtml}
        </div>
			);
		}
	}


