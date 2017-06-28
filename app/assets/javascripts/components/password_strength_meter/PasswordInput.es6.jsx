class PasswordInput extends React.Component {
    constructor(props) {
        super(props)
        this.state = {password: ''}
        this.changePassword = this.changePassword.bind(this)
    }

    changePassword(password) {
        this.setState( {password})
    }

    render() {
        let {goodPasswordRules} = this.props
        let {password} = this.state

        return (
            <ReactBootstrap.Grid>
                <ReactBootstrap.Row>
                    <ReactBootstrap.Col md={8}>
                        <PasswordField password={password}
                                        onPasswordChange={this.changePassword} />
                    </ReactBootstrap.Col>
                    <ReactBootstrap.Col md={4}>
                        <StrengthMeter rules={goodPasswordRules} password={password}/>
                    </ReactBootstrap.Col>
                </ReactBootstrap.Row>
            </ReactBootstrap.Grid>
        )
    }
}

const ALPHANUMERIC_REGEX = /[0-9]/
const LOWERCASE_REGEX = /[a-z]/
const UPPERCASE_REGEX = /[A-Z]/

PasswordInput.defaultProps = {
    goodPasswordRules: [
        {
            label: 'has 6+ characters',
            predicate: password => password.length >= 6
        },
        {
            label: 'contains at least one alphanumeric character (0-9)',
            predicate: password => password.match(ALPHANUMERIC_REGEX) !== null
        },
        {
            label: 'contains at least one lower- and one upper-case letter',
            predicate: password => (password.match(LOWERCASE_REGEX)
               !== null && password.match(UPPERCASE_REGEX) !== null)
        }
    ]
}