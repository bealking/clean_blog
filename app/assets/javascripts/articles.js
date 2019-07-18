	class ArticleForm extends React.Component {
		constructor(props) {
			super(props);
			this.state = {
			  isCreated: false,
        new_record_id: null
			};

			this.handleClick = this.handleClick.bind(this);
		}

		handleClick(event) {
      event.preventDefault();

      fetch("/"+this.props.objectType, {
          method: 'POST',
          body: JSON.stringify({body: this.refs.articleBody.value, title: this.refs.articleTitle.value}),
          headers: new Headers({
            'Content-Type': 'application/json'
          })
        })
				.then(res => res.json())
				.then(
					(result) => {
            if(result.id) {

              this.setState({
                isCreated: true,
                new_record_id: result.id
              });
            }
					}
				)
		}

    renderRedirect() {
      if (this.state.isCreated) {
        window.location.href = "/"+this.props.objectType+'/'+this.state.new_record_id
      }
    }

		render() {
			return (
			  <div>

			    <form className="form-article">
            {this.renderRedirect()}
						<div className="form-group">
							<label htmlFor="exampleInputTitle">标题</label>
							<input type="text" className="form-control" id="exampleInputTitle" ref="articleTitle" placeholder="" />
						</div>
						<div className="form-group">
							<label htmlFor="exampleInputBody">内容</label>
          		<textarea className="form-control" id="articleBody" rows="8" ref="articleBody"></textarea>
						</div>
						<button type="submit" className="btn btn-default btn-block" onClick={this.handleClick}>提交</button>
					</form>
        </div>
			);
		}
	}
