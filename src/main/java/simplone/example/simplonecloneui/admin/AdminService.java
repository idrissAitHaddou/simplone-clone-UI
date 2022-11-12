package simplone.example.simplonecloneui.admin;

import java.util.List;

public class AdminService {
    public static List getAllUsresService() {
        return AdminRepository.allUsers();
    }
}
