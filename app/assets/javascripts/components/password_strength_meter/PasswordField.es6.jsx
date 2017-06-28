class PasswordField extends React.Component {
    constructor(props){
        super(props)
        this.handlePasswordChange = this.handlePasswordChange.bind(this)
    }

    handlePasswordChange(event) {
        let { onPasswordChange } = this.props
        onPasswordChange(event.target.value)
    }
    render() {
        let {password} = this.props
        return(
            <ReactBootstrap.FormControl type='password'
                                        value={password}
                                        onChange={this.handlePasswordChange}
            />
        )
    }
}