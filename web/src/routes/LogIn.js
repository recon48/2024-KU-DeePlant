import LogInField from "../components/Log/LogInField";
import { UserProvider } from "../components/User/UserContext";

function LogIn() {
  return (
    // Wrap the LogIn component with the UserProvider
    <UserProvider>
      <div className="d-flex  align-items-center" style={{ height: "100vh" }}>
        <LogInField />
      </div>
    </UserProvider>
  );
}

export default LogIn;
